import PropTypes from 'prop-types';
import React from 'react';
import requestmanager from '../../lib/requestmanager';

export default class HelloWorld extends React.Component {
  static propTypes = {
    name: PropTypes.string.isRequired // this is passed from the Rails view
  };

  /**
   * @param props - Comes from your rails view.
   */
  constructor(props) {
    super(props);

    // How to set initial state in ES6 class syntax
    // https://reactjs.org/docs/state-and-lifecycle.html#adding-local-state-to-a-class
    this.state = {
      name: this.props.name,
      articles: []
    };
  }

  updateName = (name) => {
    this.setState({ name });
  };

  componentDidMount(){
    this.getArticles();
  }

  submitForm = () => {
    const params = { user: { nickname: this.state.name } };
    const url = '/api/v1/users/' + this.props.id;
    console.log(url)
    requestmanager.request(url, "put", params).then((resp) => {
       console.log(resp)
     }).catch(() => {});
  };

  getArticles = () => {
    const url = '/api/v1/articles';
    requestmanager.request(url).then((resp) => {
      this.setState({ articles: resp });
    }).catch(() => {});
  }

  makeArticle = (article, index) => {
    return (
      <div key={index}>
        <ul>
        <hr/>
          <div>
            <p>
            Title: {article.title}
            <br/>
            Description: {article.description}
            </p>
          </div>
        </ul>
      </div>
    );
  }

  render() {
    return (
      <div>
        <h3>
          Hello, {this.state.name}!
        </h3>
        <hr />
        <form >
          <label htmlFor="name">
            Say hello to:
          </label>
          <input
            id="name"
            type="text"
            value={this.state.name}
            onChange={(e) => this.updateName(e.target.value)}
          />
          <input
            id="submit"
            type="button"
            value="submit"
            onClick={this.submitForm}
          />
        </form>
        <div>
          {this.state.articles.map(this.makeArticle)}
        </div>
      </div>
    );
  }
}

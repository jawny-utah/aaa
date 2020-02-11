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
      articles: [],
      checked: false,
      sortingValue: "blank"
    };
    this.handleChangeForCheckbox = this.handleChangeForCheckbox.bind(this);
  };

  updateName = (name) => {
    this.setState({ name });
  };

  handleChangeForCheckbox = () => {
    this.setState({ checked: !this.state.checked });
  };

  handleChangeForSort = (event) => {
    let sortingValue = event.target.value;
    this.setState({ sortingValue }, () => {
      this.getArticles();
    });
  };

  componentDidMount() {
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
    requestmanager.request(url + '?sort_by=' + this.state.sortingValue).then((resp) => {
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
            <br/>
            Created at: {article.created_at}
            <br/>
            User email: {article.user_email}
            </p>
          </div>
        </ul>
      </div>
    );
  }

  render() {
    const { checked, articles } = this.state;
    const filteredArticles = checked ? articles.filter(a => a.user_id == this.props.id) : articles;
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
          <label>Only current user article</label>
          <input
            type="checkbox"
            checked={ this.state.checked }
            onChange={ this.handleChangeForCheckbox } />
        </div>
          <select
            value={this.state.sortingValue}
            onChange={ this.handleChangeForSort }>
              <option value="blank"> Sort by </option>
              <option value="sort_by_users_email"> Sort by user email</option>
              <option value="sort_by_title"> Sort by title</option>
              <option value="sort_by_description_length"> Sort by description</option>
          </select>
        <div>
          {filteredArticles.map(this.makeArticle)}
        </div>
      </div>
    );
  }
}

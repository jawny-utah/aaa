import PropTypes from 'prop-types';
import React from 'react';
import requestmanager from '../../lib/requestmanager';
import { Pagination, Container, Loader } from 'semantic-ui-react';

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
      user_articles: false,
      sortingValue: "blank",
      loading: true,
      pageCount: 1,
      page: 1
    };
  };

  updateName = (name) => {
    this.setState({ name });
  };

  handleChangeForCheckbox = () => {
    this.setState({ user_articles: !this.state.user_articles, page: 1 }, () => {
      this.getArticles();
    });
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

  handlePageForPagin = (e, { activePage }) => {
    this.setState({ page: activePage}, () => this.getArticles());
  }

  submitForm = () => {
    const params = { user: { nickname: this.state.name } };
    const url = '/api/v1/users/' + this.props.id;
    requestmanager.request(url, "put", params).then((resp) => {
       console.log(resp)
     }).catch(() => {});
  };

  getArticles = () => {
    const url = '/api/v1/articles';
    if (!this.state.loading) this.setState({loading: true});
    const additionalParams = {
      sort_by: this.state.sortingValue,
      page: this.state.page,
      user_articles: this.state.user_articles
    };
    const params = Object.keys(additionalParams).map(function(key, index) {
      return key + "=" + additionalParams[key];
    }).join("&");
    requestmanager.request(url + '?' + params).then((resp) => {
      this.setState({ articles: resp.articles, pageCount: resp.page_count, loading: false });
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
    if (this.state.loading) return <Loader active size="large">Loading</Loader>;
    const { articles } = this.state;
    return (
      <Container>
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
              checked={ this.state.user_articles }
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
            {articles.map(this.makeArticle)}
          </div>
          <Container>
            <Pagination onPageChange={this.handlePageForPagin} size='large' siblingRange='6'
              defaultActivePage={this.state.page}
              totalPages={this.state.pageCount}
              ellipsisItem={null}/>
          </Container>
        </div>
      </Container>
    );
  }
}

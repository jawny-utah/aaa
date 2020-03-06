import PropTypes from "prop-types";
import React from "react";
import requestmanager from "../../lib/requestmanager";
import { Pagination, Container, Loader } from "semantic-ui-react";

export default class HelloWorld extends React.Component {
  static propTypes = {
    name: PropTypes.string.isRequired // this is passed from the Rails view
  };

  constructor (props) {
    super(props);

    // How to set initial state in ES6 class syntax
    // https://reactjs.org/docs/state-and-lifecycle.html#adding-local-state-to-a-class
    this.state = {
      name: this.props.name,
      articles: [],
      user_articles: this.props.user_articles == "true",
      sortingValue: this.props.sort_by || "blank",
      loading: true,
      pageCount: 1,
      page: parseInt(this.props.page) || 1
    };
  }

  componentDidMount() {
    this.getArticles(false);
    window.onpopstate = () => {
      const state = window.history.state || {};
      this.setState( state , () => {
        this.getArticles(false);
      });
    };
  }

  updateName = (name) => {
    this.setState({ name });
  };

  handleChangeForCheckbox = () => {
    this.setState({ user_articles: !this.state.user_articles, page: 1 }, () => {
      this.getArticles();
    });
  };

  handleChangeForSort = (event) => {
    const sortingValue = event.target.value;
    this.setState({ sortingValue }, () => {
      this.getArticles();
    });
  };

  handlePageForPagin = (e, { activePage }) => {
    this.setState({ page: activePage}, () => this.getArticles());
  }

  submitForm = () => {
    const params = { user: { nickname: this.state.name } };
    const url = "/api/v1/users/" + this.props.id;
    requestmanager.request(url, "put", params).then((resp) => {
     }).catch(() => {});
  };

  getArticles = (pushState=true) => {
    const url = "/api/v1/articles";
    if (!this.state.loading) this.setState({loading: true});
    const additionalParams = {
      sort_by: this.state.sortingValue,
      page: this.state.page,
      user_articles: this.state.user_articles
    };
    const params = Object.keys(additionalParams).map(function(key, index) {
      return key + "=" + additionalParams[key];
    }).join("&");
    requestmanager.request(url + "?" + params).then((resp) => {
      this.setState({ articles: resp.articles, pageCount: resp.page_count, loading: false });
    }).catch(() => {});
    if (pushState) this.pushURLByParam();
  }

  pushURLByParam = () => {
    const additionalParams = {
      sortingValue: this.state.sortingValue,
      page: this.state.page,
      user_articles: this.state.user_articles
    };
    const url = "/hello_world";
    const params = Object.keys(additionalParams).map(function(key, index) {
      return key + "=" + additionalParams[key];
    }).join("&");
    history.pushState(additionalParams, null, url + "?" + params);
  }

  makeArticle = (article, index) => {
    return (
      <div className="articleClass" key={index}>
        <ul>
          <hr />
          <p className="articleTitle" style={{margin: 0}}>
            Title: {article.title}
          </p>
          <p className="articleDescription" style={{margin: 0}}>
            Description: {article.description}
          </p>
          <p className="articleCreatedTime" style={{margin: 0}}>
            Created at: {article.created_at}
          </p>
          <p className="articleUserEmail" style={{margin: 0}}>
            User email: {article.user_email}
          </p>
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
                onChange={(e) => this.updateName(e.target.value)}
                type="text"
                value={this.state.name} />
            <input
                id="submit"
                onClick={this.submitForm}
                type="button"
                value="submit" />
          </form>
          <div>
            <label>Only current user article</label>
            <input
                checked={this.state.user_articles}
                onChange={this.handleChangeForCheckbox}
                type="checkbox" />
          </div>
          <select
              className="selectForSort"
              onChange={this.handleChangeForSort}
              value={this.state.sortingValue}>
            <option className="sortBlank" value="blank"> Sort by </option>
            <option value="users_email"> Sort by user email</option>
            <option value="title"> Sort by title</option>
            <option value="description_length"> Sort by description</option>
          </select>
          <div className="allArticles">
            {articles.map(this.makeArticle)}
          </div>
          <Pagination
              defaultActivePage={this.state.page}
              ellipsisItem={null} onPageChange={this.handlePageForPagin}
              siblingRange='6'
              size='large'
              totalPages={this.state.pageCount} />
        </div>
      </Container>
    );
  }
}

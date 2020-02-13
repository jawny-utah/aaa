import PropTypes from "prop-types";
import React from "react";
import requestmanager from "../../lib/requestmanager";
import { Pagination, Container } from "semantic-ui-react";

class HelloWorld extends React.Component {
  /**
   * @param props - Comes from your rails view.
   */
  constructor (props) {
    super(props);

    // How to set initial state in ES6 class syntax
    // https://reactjs.org/docs/state-and-lifecycle.html#adding-local-state-to-a-class
    this.state = {
      name: this.props.name,
      articles: [],
      checked: false,
      sortingValue: "blank",
      loading: true,
      pageCount: 1,
      page: 1
    };
    this.handleChangeForCheckbox = this.handleChangeForCheckbox.bind(this);
  }

  componentDidMount () {
    this.getArticles();
  }

  handleChangeForCheckbox = () => {
    this.setState({ checked: !this.state.checked });
  };

  handleChangeForSort = (event) => {
    const sortingValue = event.target.value;
    this.setState({ sortingValue }, () => {
      this.getArticles();
    });
  };

  updateName = (name) => {
    this.setState({ name });
  };

  handlePageForPagin = (e, { activePage }) => {
    const gotopage = { activePage };
    const pagenum = gotopage.activePage;
    const pagestring = pagenum.toString();
    const url = "/api/v1/articles";
    requestmanager.request(url + "?page=" + pagestring).then((resp) => {
      this.setState({ page: activePage, loading: false, articles: resp.articles });
    }).catch(() => {});
  }

  submitForm = () => {
    const params = { user: { nickname: this.state.name } };
    const url = "/api/v1/users/" + this.props.id;
    console.log(url);
    requestmanager.request(url, "put", params).then((resp) => {
      console.log(resp);
    }).catch(() => {});
  };

  getArticles = () => {
    const url = "/api/v1/articles";
    requestmanager.request(url + "?sort_by=" + this.state.sortingValue).then((resp) => {
      this.setState({ articles: resp.articles, pageCount: resp.page_count });
    }).catch(() => {});
  }

  makeArticle = (article, index) => {
    return (
      <div key={index}>
        <ul>
          <hr />
          <div>
            <p>
              Title: {article.title}
              <br />
              Description: {article.description}
              <br />
              Created at: {article.created_at}
              <br />
              User email: {article.user_email}
            </p>
          </div>
        </ul>
      </div>
    );
  }

  render () {
    const { checked, articles } = this.state;
    const filteredArticles = checked ? articles.filter(a => a.user_id === this.props.id) : articles;
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
                handleonClick={this.submitForm}
                id="submit"
                type="button"
                value="submit" />
          </form>
          <div>
            <label>Only current user article</label>
            <input
                checked={this.state.checked}
                onChange={this.handleChangeForCheckbox}
                type="checkbox" />
          </div>
          <select
              onChange={this.handleChangeForSort}
              value={this.state.sortingValue}>
            <option value="blank"> Sort by </option>
            <option value="sort_by_users_email"> Sort by user email</option>
            <option value="sort_by_title"> Sort by title</option>
            <option value="sort_by_description_length"> Sort by description</option>
          </select>
          <div>
            {filteredArticles.map(this.makeArticle)}
          </div>
          <Container>
            <Pagination
                defaultActivePage={this.state.page} ellipsisItem={null} onPageChange={this.handlePageForPagin}
                siblingRange='6'
                size='large'
                totalPages={this.state.pageCount} />
          </Container>
        </div>
      </Container>
    );
  }
}

HelloWorld.propTypes = {
  name: PropTypes.string.isRequired
};

export default HelloWorld;

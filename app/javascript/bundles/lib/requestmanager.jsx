import "isomorphic-fetch";
import ReactOnRails from "react-on-rails";

export default {
  request(endpoint, method="get", params=null) {
    let body;
    if (params) body = JSON.stringify(params);
    let headers = {
      method: method,
      credentials: "include",
      headers: ReactOnRails.authenticityHeaders()
    };
    if (body) headers.body = body;
    return (
      fetch(endpoint, headers)
        .then(response => response.json()).catch(() => {})
    );
  },
};

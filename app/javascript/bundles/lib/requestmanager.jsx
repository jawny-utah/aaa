import "isomorphic-fetch";
import ReactOnRails from "react-on-rails";

export default {
  request(endpoint, params, method="put") {
    const body = JSON.stringify(params);
    return (
      fetch(endpoint,
            {
              method: method,
              body,
              credentials: "include",
              headers: ReactOnRails.authenticityHeaders()
            })
        .then(response => response.json()).catch(() => {})
    );
  },
}

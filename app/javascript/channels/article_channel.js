import consumer from "./consumer"
window.subArticles = function(id) {
  consumer.subscriptions.create({channel: "ArticleChannel", id: id}, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      location.reload();
      // Called when there's incoming data on the websocket for this channel
    }
  });
}

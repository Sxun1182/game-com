import consumer from "./consumer"

consumer.subscriptions.create({ channel: "ChatRoomChannel", chat_room_id: 1 }, {
  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const user_element = `<div class="user">${data.user}</div>`;
    const message_element = `<div class="message">${data.message}</div>`;
    const messages_container = document.querySelector('.messages');
    messages_container.innerHTML += user_element + message_element;
  },

  send_message(message) {
    this.perform('send_message', { message: message, chat_room_id: 1 });
  }
});

//consumer.subscriptions.create("ChatRoomChannel", {
  //connected() {
    // Called when the subscription is ready for use on the server
  //},

  //disconnected() {
    // Called when the subscription has been terminated by the server
  //},

  //received(data) {
    // Called when there's incoming data on the websocket for this channel
  //}
//});

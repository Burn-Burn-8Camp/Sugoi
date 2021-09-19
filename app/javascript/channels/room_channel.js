import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const room_element = document.getElementById('message_room_id');
  if(!room_element) return

  const room_id = room_element.value

  consumer.subscriptions.subscriptions.forEach((subscription) => {
    consumer.subscriptions.remove(subscription)
  })

  consumer.subscriptions.create({ channel: "RoomChannel", room_id: room_id }, {
    connected() {
      console.log("connected to " + room_id)
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log(data)
      // const user_element = document.getElementById('user-id');
      // const user_id = Number(user_element.getAttribute('data-user-id'));

      const message_content = document.getElementById('chat-room-content')
      message_content.innerHTML = message_content.innerHTML + `<p>${data.message} - ${data.user_name}</p>`
      // let html;

      // if (user_id === data.message.user_id) {
      //   html = data.mine
      // } else {
      //   html = data.theirs
      // }

      // const messageContainer = document.getElementById('messages')
      // messageContainer.innerHTML = messageContainer.innerHTML + html
    }
  });
})


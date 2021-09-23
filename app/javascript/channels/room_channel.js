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
    },

    disconnected() {
    },

    receivde(data) {
      const send_btn = document.getElementById('send-btn');
      const content = document.getElementById('message_content');
      const message_content = document.getElementById('chat-room-content')
      message_content.innerHTML = message_content.innerHTML + `<p>${data.message} - ${data.user_name} [ ${data.datetime} ] </p><div style="width: 30px"><img src="${data.image}"></div>`

      send_btn.disabled = false;
      content.value = ''
    }
  });
})


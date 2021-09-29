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
      console.log('connected')
    },
    disconnected() {
    },
    received(data) {
      const send_btn = document.getElementById('send-btn');
      const content = document.getElementById('message_content');
      const message_content = document.getElementById('chat-room-content')
      const user_element = document.getElementById('message_user_id')
      const user_id = user_element.value
      if(user_id == data.user_id) {
        message_content.innerHTML = message_content.innerHTML + `<div class="w-full flex justify-end" ><div class="bg-gray-100 rounded px-5 py-2 my-2 text-gray-700 relative" style="max-width: 300px;"><span class="block">${ data.message }</span><span class="block text-xs text-left">${ new Date(data.datetime).toLocaleTimeString() }</span></div></div>`
      } else {
        message_content.innerHTML = message_content.innerHTML + `<div class="w-full flex justify-start" ><div class="bg-gray-100 rounded px-5 py-2 my-2 text-gray-700 relative" style="max-width: 300px;"><span class="block">${ data.message }</span><span class="block text-xs text-right">${ new Date(data.datetime).toLocaleTimeString() }</span></div></div>`
      }
      send_btn.disabled = false;
      content.value = ''
    },
  });
})


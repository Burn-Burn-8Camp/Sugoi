import consumer from "./consumer"

document.addEventListener('turbolinks:load', ()=>{

  const element = document.getElementById('room-id')
  const room_id = element.getAttribute('data-room-id')

  consumer.subscriptions.create({ channel: "RoomChannel",room_id}, {

    connected() {
      console.log( "connect to room channel" + room_id)
    },  
    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log(data)
    }
  });  
})




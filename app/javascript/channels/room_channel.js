import consumer from "./consumer"

document.addEventListener('turbolinks:load', ()=>{

  const element = document.getElementById('room-id')
  const room_id = element.getAttribute('data-room-id')

  consumer.subscriptions.create({ channel: "RoomChannel",room_id: room_id}, {

    connected() {
      //Called when the subscription isredy for use on the server
      console.log( "connect to room channel" + room_id)
    },  
    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      console.log(data)
    }
  });  
})




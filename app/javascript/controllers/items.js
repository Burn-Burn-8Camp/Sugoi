import Rails from "@rails/ujs";
document.addEventListener("turbolinks:load", () => {
  
  const menu = document.querySelector('.item-qantity select')
  const price = document.querySelector('.subtotal')
  const itemPrice = Number(price.innerText)
  const totalPrice = document.querySelector('.total-price')

  menu.addEventListener("click", (e) => {  
    let quantity = e.target.value  
    price.innerText = itemPrice * quantity
  })

  // Rails.ajax({
  //     url: url,
  //     type: "post",
  //     data: {
  //       id: ,
  //       quantity: quantity
  //     },
  //     success: (data) => {
  //       const icon = this.iconTarget;

  //       if (data.status === "added") {
  //         icon.classList.remove("favorite-off");
  //         icon.classList.add("favorite-on");
  //       } else {
  //         icon.classList.remove("favorite-on");
  //         icon.classList.add("favorite-off");
  //       }
  //     },
  //     error: function (err) {
  //       console.log(err);
  //     },
  //   });


})
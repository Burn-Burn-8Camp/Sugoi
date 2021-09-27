import Rails from "@rails/ujs";

document.addEventListener("turbolinks:load", () => {
  const selectedItems = document.querySelector(".selected_items")
  const deleteItemButtons = document.querySelectorAll(".delete-item-button")
  const cartItems = document.querySelectorAll(".cart-item")
  const delivery = document.querySelector(".summary-delivery-price .total_price")
  const shoppingCartItems = document.querySelector(".indicator .indicator-item")
  const coupon = document.querySelector(".coupon_value")
  let totalPrice = document.querySelector(".summary-product-price .total_price")
  let sum = document.querySelector(".sum")

  console.log(coupon.textContent)
  console.log(typeof(0))
  
  if(selectedItems) {
    const dropDownMenu = document.querySelector(".productID")
    const deliveryFee = Number(delivery.textContent)
    let couponValue = document.querySelector(".summary-coupon-redeem .coupon_value")
  
    selectedItems.addEventListener("change", (e) => {   
      if(e.target.classList.value.includes("productID")) {
        dropDownMenu.setAttribute("selected", "selected")       
        const productId = e.target.id
        let quantity = e.target.value    
        changeQuantity(productId, quantity)
      }

      function changeQuantity(id, q) {
        const url ='/cart/confirmation';
        let params = new URLSearchParams()
        
        params.append('product_id', id)
        params.append('quantity', q)
        Rails.ajax({
          url: url,
          type: "post",
          data: params,
          success: (data) => {
            totalPrice.textContent = data.itemsPrice
            sum.textContent =  data.itemsPrice + deliveryFee - Number(couponValue.textContent)         
          },
          error: function (err) {
            console.log(err);
          },
        });
      }
    })

    for(const deleteItemButton of deleteItemButtons) {
      deleteItemButton.addEventListener("click", (e) => {
        const productId = e.currentTarget.id
        deleteItem(productId)
        cartItems.forEach( cartItem => {
          if (Number(cartItem.dataset.id) === Number(productId)) {
            cartItem.classList.add("hidden")       
          }
        })
      })
    }

    function deleteItem(id) {
      const url ='/cart/delete_item';
      let params = new URLSearchParams()
        
      params.append('product_id', id)
      Rails.ajax({
        url: url,
        type: "post",
        data: params,
        success: (data) => {
          console.log(data)
          console.log(coupon.value)
          if (data.subtotal === 0) {
            totalPrice.textContent = data.subtotal
            delivery.textContent = 0
            sum.textContent = 0
            shoppingCartItems.textContent = 0
            coupon.textContent = 0
          } else if (coupon.textContent) {
            console.log('hi')
            totalPrice.textContent = data.subtotal
            delivery.textContent = data.delivery_fee
            sum.textContent = data.subtotal + data.delivery_fee - Number(coupon.textContent)
            shoppingCartItems.textContent = data.itemsQuantity
            console.log(coupon)
          } else {
            totalPrice.textContent = data.subtotal
            delivery.textContent = data.delivery_fee
            sum.textContent = data.subtotal + data.delivery_fee
            shoppingCartItems.textContent = data.itemsQuantity
          
          }
        },
        error: function (err) {
          console.log(err);
        },
      });
    } 
  } 
})
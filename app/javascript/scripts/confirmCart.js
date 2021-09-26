import Rails from "@rails/ujs";

document.addEventListener("turbolinks:load", () => {
  const selectedItems = document.querySelector(".selected_items")
  const deleteItemButtons = document.querySelectorAll(".delete-item-button")
  const cartItems = document.querySelectorAll(".cart-item")
  const delivery = document.querySelector(".summary-delivery-price .total_price")
  let totalPrice = document.querySelector(".summary-product-price .total_price")
  let sum = document.querySelector(".sum")
  
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
          success: (itemsPrice) => {
            totalPrice.textContent = itemsPrice
            sum.textContent = itemsPrice + deliveryFee - Number(couponValue.textContent)           
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
          totalPrice.textContent = data.subtotal
          delivery.textContent = data.total_delivery_fee
          sum.textContent = data.subtotal + data.total_delivery_fee - Number(couponValue.value) 
        },
        error: function (err) {
          console.log(err);
        },
      });
    } 
  } 
})
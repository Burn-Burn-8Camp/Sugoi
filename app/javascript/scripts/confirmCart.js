import Rails from "@rails/ujs";

document.addEventListener("turbolinks:load", () => {
  const selectedItems = document.querySelector(".selected_items")
  const delivery = document.querySelector(".summary-delivery-price .total_price")
  let totalPrice = document.querySelector(".total_price")
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
  }  

})
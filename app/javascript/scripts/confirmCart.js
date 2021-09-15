import Rails from "@rails/ujs";

document.addEventListener("turbolinks:load", () => {
  const selectedItems = document.querySelector(".selected_items")
  let totalPrice = document.querySelector(".total_price")
  let sum = document.querySelector(".sum")
  
  if(selectedItems) {
    const dropDownMenu = document.querySelector(".productID")
  
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
            totalPrice.textContent = data
            sum.textContent = data
          },
          error: function (err) {
            console.log(err);
          },
        });
      }
    })
  }  
})
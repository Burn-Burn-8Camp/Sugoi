import Rails from "@rails/ujs";

document.addEventListener("turbolinks:load", () => {
  const selectedItems = document.querySelector(".selected_items")
  
  if(selectedItems) {
    const dropDownMenu = document.querySelector(".productID")

    selectedItems.addEventListener("change", (e) => {   
      console.log(dropDownMenu.innerHTML)

      if(e.target.classList.value.includes("productID")) {
        dropDownMenu.setAttribute("selected", "selected")

        let productId = e.target.id
        let quantity = e.target.value
        console.log(e.target.id)
        console.log(e.target.value)
        
        changQuantity(productId, quantity)
      }


      function changQuantity(id, q) {
        const url ='/cart/confirmation';
        let param = new URLSearchParams()
        param.append('product_id', id)
        param.append('quantity', q)

        Rails.ajax({
          url: url,
          type: "post",
          data: param,
          success: (data) => {
            console.log(data);
          },
          error: function (err) {
            console.log(err);
          },
        });
      }
    })

  }
  
})
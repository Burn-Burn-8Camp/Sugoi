import Rails from "@rails/ujs";

document.addEventListener("turbolinks:load", () => {
  const div = document.querySelector(".selected_items")
  
  if(div) {
    div.addEventListener("change", (e) => {
    
    if(e.target.classList.value.includes("productID")) {
      let productId = e.target.id
      let quantity = e.target.value

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
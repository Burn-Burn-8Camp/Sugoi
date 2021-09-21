import Rails from "@rails/ujs";


document.addEventListener("turbolinks:load", () => {
	const heartIcon = document.querySelector("#heart")
	const label = document.querySelector("#productId")
	var id = label.dataset.id
	heartIcon.addEventListener("click", () => {
		Rails.ajax({
      url: `/products/${id}/favorite`,
      type: "post",
      data: "",
      success: (res) => {
          console.log(res)  
      },
      error: function (err) {
        console.log(err);
      },
    });
		
	})
})



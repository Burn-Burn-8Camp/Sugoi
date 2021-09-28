import Rails from "@rails/ujs";


document.addEventListener("turbolinks:load", () => {
	const heartIcon = document.querySelector("#heart")
	if (heartIcon) {
    heartIcon.addEventListener("click", () => {
      var id = heartIcon.dataset.id
      Rails.ajax({
        url: `/products/${id}/favorite`,
        type: "post",
        data: "",
        success: (data) => {  
          if(data.status === "added") {
            heartIcon.classList.add("text-red-400");
          } else {
            heartIcon.classList.remove("text-red-400")
          }
        },
        error: function (err) {
          console.log(err);
        },
      });
    })
  }
})



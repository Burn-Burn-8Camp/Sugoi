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
      success: (data) => {


        if(data.status === "added") {
          heartIcon.classList.remove("text-gray-300");
          heartIcon.classList.add("text-red-500");
        } else {
          heartIcon.classList.remove("text-red-500")
          heartIcon.classList.add("text-gray-300")
        }
      },
      error: function (err) {
        console.log(err);
      },
    });
		
	})
})



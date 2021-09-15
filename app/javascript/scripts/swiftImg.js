document.addEventListener("turbolinks:load", () => {
	var currentIndex = 0
	var imgNumber = document.querySelectorAll('.tabImg').length
	var images = document.querySelectorAll('.tabImg')
	var tabBtn = document.querySelectorAll('.tabBtn')
	setInterval(imgRun, 2000)

	function imgRun() {
		currentIndex = ++currentIndex === imgNumber ? 0 : currentIndex
		slideTo(currentIndex)
	}

	function slideTo(index) {
		var int = parseInt(index)
		images.forEach((image, index) => {
			if (index === int) {
				images[index].classList.remove('hidden')
			} else {
				images[index].classList.add('hidden')
			}
		})
		images.forEach((image, index) => {
			if (index === int) {
				tabBtn[index].classList.add('bg-yellow-500')
				tabBtn[index].classList.remove('bg-gray-300')
			} else {
				tabBtn[index].classList.remove('bg-yellow-500')
				tabBtn[index].classList.add('bg-gray-300')
			}
		})
	}
})
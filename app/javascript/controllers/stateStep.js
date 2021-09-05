document.addEventListener("turbolinks:load", () => {
	const stepList = document.querySelectorAll('.order-steps li')
	const state = document.querySelector('#order-state')

	stepList.forEach((li, index) => {
		if (li.id == state.innerText) {
			for (var i = 0; i <= index; i++) {
				stepList[i].classList.add('step-primary')
			}
		}
	})
})
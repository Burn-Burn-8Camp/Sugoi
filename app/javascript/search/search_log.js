document.addEventListener("DOMContentLoaded", () => {
    const button = document.querySelector(".search-icon")
    const input = document.querySelector(".input-serarch")

    button.addEventListener("click", () => {
        console.log('被按了')
    })

    input.addEventListener("change", () => {
        console.log(input.value)
    })

})
document.addEventListener("turbolinks:load", () => {
  const picGroup = document.querySelectorAll("#pic-group img")
  const bigPic = document.querySelector("#big-pic")
  if (picGroup){
    picGroup.forEach((pic)=>{
      pic.addEventListener("click",(e) =>{
        bigPic.src = e.target.src
      })
    })
  }    
})
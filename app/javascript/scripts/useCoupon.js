import Rails from "@rails/ujs";

document.addEventListener("turbolinks:load", () => {
  const coupons = document.querySelector(".user-coupon")
  let sum = document.querySelector(".sum")
  let couponValue = document.querySelector(".summary-coupon-redeem .coupon_value")

  if (coupons){
    coupons.addEventListener("click", (e) => { 
      if(e.target.name === "coupon") {
        console.log(e.target)
        const coupon_id = e.target.id
        const coupon_value = e.target.value
        useCoupon(coupon_id, coupon_value)
      }
    })

    function useCoupon(id, value) {
      const url ='/cart/redeem';
      let params = new URLSearchParams()
      
      params.append('coupon_id', id)
      params.append('value', value)
    
      Rails.ajax({
        url: url,
        type: "post",
        data: params,
        success: (data) => {
          sum.textContent = data.total
          couponValue.textContent = data.value
        },
        error: function (err) {
          console.log(err);
        },
      });
    }
  }
})
// import { Controller } from "stimulus";
// import Rails from "@rails/ujs";

// export default class extends Controller {
//   static targets = ["id", "quantity"];


//   change() {
//     this.changQuantity(this.idTarget.innerText, this.quantityTarget.value);
//   }



//   changQuantity(id, q) {
//     const url ='/cart/confirmation';
//     let param = new URLSearchParams()
//     param.append('product_id', id)
//     param.append('quantity', q)

//     Rails.ajax({
//       url: url,
//       type: "post",
//       data: param,
//       success: (data) => {
//         console.log(data);
//       },
//       error: function (err) {
//         console.log(err);
//       },
//     });
//   }
// }
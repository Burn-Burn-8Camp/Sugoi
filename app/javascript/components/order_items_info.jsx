import React, { useState } from 'react'
import Rails from '@rails/ujs'
import PumpUpScreen from './pump_up_screen'

const OrderItem = ({name, quantity, price}) => {
	return (
		<div className="grid grid-cols-5 my-5">
			<div className="col pr-3">
				<img src="http://fakeimg.pl/100x100/ecf0f1/" alt="product_img" />
			</div>
			<div className='col-span-2'>
				<span className='block'>{name}</span>
				<PumpUpScreen />
			</div>
			<div className="col text-right">x {quantity}</div>
			<div className="col text-right">NT$ {parseInt(price)}</div>
		</div>
	)
}

const OrderItemsInfo = () => {
	const[items, setItems] = React.useState([])
	const url = window.location.pathname
	const orderId = document.querySelector("#order_id")
	
	let params = new URLSearchParams()
	params.append('order_id', orderId.dataset.id)

	React.useEffect(() => {
		Rails.ajax({
			url: `${url}/items_info`,
			type: 'post',
			data: params,
			success:  (res) => {
				setItems(res)
			},
			error: function(err) {
				console.log(err);
			}
		}) 
	}, [])

	return (
		<div>
			{
			items.map((item) => {
				return (
					<OrderItem
					key={item.id}
					name={item.name}
					quantity={item.quantity}
					price={item.price} />	
				)
			})
			}
		</div>
	)
}

export default OrderItemsInfo;
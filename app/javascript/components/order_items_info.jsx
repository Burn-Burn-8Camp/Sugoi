import React, { useState } from 'react'
import Rails from '@rails/ujs'
import PopUpScreen from './pop_up_screen'
import RateStar from './star_rate'

const StarList = ({ rate }) => {
	const starIndex = [1, 2, 3, 4, 5]
	return (
		starIndex.map((star, index) => {
			const starStyle = index < rate ? 'text-yellow-400 text-xl' : 'text-gray-200 text-xl'
			return <RateStar key={star} starStyle={starStyle} />
		})
	)
}

const OrderItem = ({ itemId, name, quantity, price, orderId, rate }) => {
	return (
		<div className="grid grid-cols-5 my-5">
			<div className="col pr-3">
				<img src="http://fakeimg.pl/100x100/ecf0f1/" alt="product_img" />
			</div>
			<div className='col-span-2'>
				<span className='block'>{name}</span>				
				{ rate == 0 ? <PopUpScreen itemId={itemId} orderId={orderId}/> : <StarList rate={rate} /> }
			</div>
			<div className="col text-right">x {quantity}</div>
			<div className="col text-right">NT$ {parseInt(price)}</div>
		</div>
	)
}

const OrderItemsInfo = () => {
	const[items, setItems] = React.useState([])
	const orderUrl = window.location.pathname
	const orderId = document.querySelector("#order_id")
	
	let params = new URLSearchParams()
	params.append('order_id', orderId.dataset.id)

	React.useEffect(() => {
		Rails.ajax({
			url: `${orderUrl}/items_info`,
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
					itemId={item.id}
					orderId={orderId.dataset.id}
					name={item.name}
					quantity={item.quantity}
					price={item.price}
					rate={item.rate} />	
				)
			})
			}
		</div>
	)
}

export default OrderItemsInfo;
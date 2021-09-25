import React, { useState } from 'react'
import Rails from '@rails/ujs'
import BuyerCommentForm from './buyer_comment_form'
import StarList from './star_list'

const Store = ({storeName}) => {
	return (
		<>
			<h3 className='mt-2'>{storeName}</h3>
		</>
	)
} 

const OrderItem = ({ itemId, name, quantity, price, orderId, rate, content }) => {
	return (
		<div className="grid grid-cols-5 my-5">
			<div className="col pr-3">
				<img src="http://fakeimg.pl/100x100/ecf0f1/" alt="product_img" />
			</div>
			<div className='col-span-2'>
				<span className='block pb-3'>{name}</span>
				{rate == 0 ? <BuyerCommentForm itemId={itemId} orderId={orderId}/> : <StarList rate={rate} content={content} />}
			</div>
			<div className="col text-right">x {quantity}</div>
			<div className="col text-right">NT$ {parseInt(price)}</div>
		</div>
	)
}

const OrderItemsInfo = ({ order_id }) => {
	const [storeItems, setStoreItems] = React.useState([])
	const orderUrl = window.location.pathname
	
	let params = new URLSearchParams()
	params.append('order_id', order_id)

	React.useEffect(() => {
		Rails.ajax({
			url: `${orderUrl}/items_info`,
			type: 'post',
			data: params,
			success:  (res) => {
				setStoreItems(res)
			},
			error: function(err) {
				console.log(err);
			}
		}) 
	}, [])

	return (
		<>
			{
			storeItems.map((item_arr, index) => {
				return (
					<div key={index}>
						<Store
						storeName={item_arr.store_name} />
						{
							item_arr.items.map((item, index) => {
								return (
									<OrderItem
									key={index}
									itemId={item.id}
									orderId={order_id}
									name={item.name}
									quantity={item.quantity}
									price={item.price}
									rate={item.rate}
									content={item.content} />
								)
							})
						}
					</div>
				)
			})
			}
		</>
	)
}

export default OrderItemsInfo;
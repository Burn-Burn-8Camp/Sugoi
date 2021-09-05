import React, { useState, useEffect, useReducer } from 'react';
import axios from 'axios';

const UserOrders = ({serial, total, state}) => {
	return (
		<tr>
			<td>{serial}</td>
			<td>{total}</td>
			<td>{state}</td>
			<td><button className='btn'>push</button></td>
		</tr>
	)
}

const StateSteps =  () => {
	const [list, setList] = React.useState([])
	React.useEffect(() => {
		axios
			.get('/orders/')
			.then(json => {
				setList(json.data)
			})
			.catch( err => {
				console.log(err);
			})
	}, []);

	return (
		<div>
			<table>
				<thead>
					<tr>
						<th>訂單序號</th>
						<th>訂單總金額</th>
						<th>訂單狀態</th>
						<th>訂單明細</th>
					</tr>
				</thead>
				<tbody>
					{
					list.map((order) => {
						return (
							<UserOrders
								key={order.id}
								serial={order.serial}
								total={order.total}
								state={order.state} />
						)
					})
					}
				</tbody>
			</table>
		</div>
	)
}


export default StateSteps;
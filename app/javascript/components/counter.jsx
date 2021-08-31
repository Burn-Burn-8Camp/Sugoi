import PropTypes from 'prop-types';
import React, { useState } from 'react';

const Counter = ({init = 0}) => {
	// 可以預設值、可以解構
	const [count, setCount] = useState(init)
	const atClick = () => {
		setCount(count + 1)
	}
	return (
		<div className="counter">
			<h1 className='text-3xl'>Counter</h1>
			<div className='text-2xl'>{count}</div>
			<button className="border-4" onClick={atClick}>+1</button>
		</div>
	)	
}
  
export default Counter
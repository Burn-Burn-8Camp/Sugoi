import React, { useState } from 'react';

const SwiftImg =  () => {
	const [currentIndex, setCurrentIndex] = React.useState(0)
	var timer = setInterval( () => {
		currentIndex = ++currentIndex === 2 
	}, 2000)


	return (
		

	)
}


export default SwiftImg
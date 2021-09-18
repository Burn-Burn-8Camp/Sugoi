import React from 'react'
import { library } from "@fortawesome/fontawesome-svg-core";
import { fas } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
library.add(fas);

const StarRate = ({ starStyle }) => {
	return (
		<span className='inline-block'>
			<FontAwesomeIcon icon={['fas', 'star']} className={starStyle} />
		</span>
	)
}

const StarList = ({ rate }) => {
	const starIndex = [1, 2, 3, 4, 5]
	return (
		<div>
			{
			starIndex.map((star, index) => {
				const starStyle = index < rate ? 'text-yellow-400 text-xl' : 'text-gray-200 text-xl'
				return <StarRate key={star} starStyle={starStyle} />
			})
			}
		</div>
	)
}

export default StarList
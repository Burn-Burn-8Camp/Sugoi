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

const StarList = ({ rate, content }) => {
	const starIndex = [1, 2, 3, 4, 5]
	return (
		<div className='mt-3'>
			{
			starIndex.map((star, index) => {
				const starStyle = index < rate ? 'text-yellow-400 text-xl' : 'text-gray-200 text-xl'
				return (
					<StarRate key={star} starStyle={starStyle} />
				)
			})
			}
			<p className='pt-3'>{content}</p>
		</div>
	)
}

export default StarList
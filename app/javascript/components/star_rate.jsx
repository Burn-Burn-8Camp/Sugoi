import React from 'react'
import { library } from "@fortawesome/fontawesome-svg-core";
import { fas } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
library.add(fas);

const RateStar = ({ starStyle }) => {
	return (
		<span className='inline-block'>
			<FontAwesomeIcon icon={['fas', 'star']} className={starStyle} />
		</span>
	)
}

export default RateStar
import { library } from "@fortawesome/fontawesome-svg-core";
import { fas } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
library.add(fas);

const Rate = ({ id, starStyle }) => {
	const [rateValue, setRateValue] = useState(5);
	return (
		<span className='inline-block'>
			<FontAwesomeIcon icon={['fas', 'star']} onClick={toggleStar} className={starStyle} />
		</span>
	)
}

export default Rate
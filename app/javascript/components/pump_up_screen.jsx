import React, { useState } from 'react'
import Modal from 'react-modal'
import { library } from "@fortawesome/fontawesome-svg-core";
import { fas } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
library.add(fas);



const PumpUpScreen = () =>  {
  const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");
  const [isOpen, setIsOpen] = useState(false);
  const [rateValue, setRateValue] = useState(5);

  const toggleModal = () => {
    setIsOpen(!isOpen);
  }
  const Star = ({id, starStyle}) => {
    const toggleStar = () => {
      setRateValue(id)
    }
    return (
      <span className='inline-block'>
        <FontAwesomeIcon icon={['fas', 'star']} onClick={toggleStar} className={starStyle} />
      </span>
    )
  }

  return (
    <div className="PumpUpScreen mb-3">
      <button onClick={toggleModal} className='btn btn-primary'>商品評價</button>

      <Modal
				ariaHideApp={false}
        isOpen={isOpen}
        onRequestClose={toggleModal}
				className="myModal"
        overlayClassName="myOverlay"
        contentLabel="commentForm">
        <h3 className='pb-3'>請填寫對於商品的評價</h3>
				<hr />
				<form action="http://localhost:3000/orders/order_form" method='POST'>
          <div>
            <input type="hidden" value={csrf} name='authenticity_token'/>
          </div>
					<div>
            <label htmlFor="rate">商品滿意度</label>
            <input type="hidden" name='rate' value={rateValue}/>
            {
              [1, 2, 3, 4, 5].map((star, index) => {
                const starStyle = index < rateValue ? 'text-yellow-400' : 'text-gray-200'
                return <Star id={star} key={star} starStyle={starStyle} />
              })
            }
          </div>
					<div>
            <label htmlFor="content">商品評論</label>
            <textarea name="content" cols="20" rows="5" placeholder='我很滿意這個商品' className='w-full my-2'></textarea>
          </div>
					<div className='flex flex-row-reverse'>
            <input type="submit" className='btn btn-primary my-2 mr-3' value='送出'/>
            <button onClick={toggleModal} className='btn btn-success my-2 mr-3'>關閉</button>
          </div>
				</form>
      </Modal>
    </div>
  );
}

export default PumpUpScreen;
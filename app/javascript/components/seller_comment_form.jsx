import React, { useState } from 'react'
import Modal from 'react-modal'
import { library } from "@fortawesome/fontawesome-svg-core";
import { fas } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
library.add(fas);

const SellerCommentForm = ({ order_id }) =>  {
  const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");
  const commentUrl = `http://localhost:3000/store/orders/${order_id}/comment/create`;
  const starIndex = [1, 2, 3, 4, 5];
  const [isOpen, setIsOpen] = useState(false);
  const [rateValue, setRateValue] = useState(5);

  const toggleModal = () => {
    setIsOpen(!isOpen);
  }

  const Star = ({ id, starStyle }) => {
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
    <div className="SellerCommentForm mb-3">
      <button onClick={toggleModal} className='btn btn-primary'>賣家評價</button>

      <Modal
				ariaHideApp={false}
        isOpen={isOpen}
        onRequestClose={toggleModal}
				className="myModal"
        overlayClassName="myOverlay"
        contentLabel="commentForm">
        <h3 className='pb-3'>請填寫對於買家的評價</h3>
				<hr />
				<form action={commentUrl} method='POST'>
          <div>
            <input type="hidden" value={csrf} name='authenticity_token'/>
            <input type="hidden" value={order_id} name='order_id'/>
          </div>
					<div className='p-3'>
            <label htmlFor="rate" className='mr-2 text-lg'>滿意度</label>
            <input type="hidden" name='rate' value={rateValue}/>
            {
              starIndex.map((star, index) => {
                const starStyle = index < rateValue ? 'text-yellow-400 text-xl' : 'text-gray-200 text-xl'
                return <Star id={star} key={star} starStyle={starStyle} />
              })
            }
          </div>
					<div className='p-3'>
            <label htmlFor="content" className='text-lg'>評論</label>
            <textarea name="content" cols="20" rows="5" placeholder='優質的好買家' className='w-full my-2 border-2 rounded'></textarea>
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

export default SellerCommentForm;
import React, { useState } from 'react'
import Modal from 'react-modal'

const PumpUpScreen = () =>  {
  const [isOpen, setIsOpen] = useState(false);

  function toggleModal() {
    setIsOpen(!isOpen);
  }

  return (
    <div className="PumpUpScreen mb-3">
      <button onClick={toggleModal} class='btn btn-primary'>請填寫收件人與購買人資料</button>

      <Modal
				ariaHideApp={false}
        isOpen={isOpen}
        onRequestClose={toggleModal}
				className="mymodal"
        overlayClassName="myoverlay"
        contentLabel="addressForm">
        <h3 className='pb-3'>請填寫收件人與購買人資料</h3>
				<hr />
				<form action="">
					<div>
            <label htmlFor="receiver">收件人姓名</label>
            <input type="text" className='w-full my-2' placeholder='真實姓名'/>
          </div>
					<div>
            <label htmlFor="tel">收件人手機</label>
            <input type="text" className='w-full my-2' />
          </div>
					<div>
            <label htmlFor="address">地址</label>
            <input type="text" className='w-full my-2' placeholder='例：台北市襄陽路1號1樓'/>
          </div>
					<div className='flex flex-row-reverse'>
            <input type="submit" className='btn btn-primary my-2 mr-3'/>
            <button onClick={toggleModal} className='btn btn-success my-2 mr-3'>close</button>
          </div>
				</form>
      </Modal>
    </div>
  );
}

export default PumpUpScreen;
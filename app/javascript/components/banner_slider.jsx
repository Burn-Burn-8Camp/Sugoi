import React from "react";
import Slider from "react-slick";

const BannerSlider = () => {
  const settings = {
    dots: true,
    infinite: true,
    speed: 500,
    slidesToShow: 1,
    slidesToScroll: 1
  };
  return (
    <div>
      <Slider {...settings}>
        <div>
          <img src="https://picsum.photos/1400/400?random=2" alt="fakePic"  className='w-full'/>
        </div>
        <div>
          <img src="https://picsum.photos/1400/400?random=3" alt="fakePic"  className='w-full'/>
        </div>
        <div>
          <img src="https://picsum.photos/1400/400?random=4" alt="fakePic"  className='w-full'/>
        </div>
        <div>
          <img src="https://picsum.photos/1400/400?random=5" alt="fakePic"  className='w-full'/>
        </div>
        <div>
          <img src="https://picsum.photos/1400/400?random=6" alt="fakePic"  className='w-full'/>
        </div>
        <div>
          <img src="https://picsum.photos/1400/400?random=7" alt="fakePic"  className='w-full'/>
        </div>
      </Slider>
    </div>
  );
  
}
export default BannerSlider
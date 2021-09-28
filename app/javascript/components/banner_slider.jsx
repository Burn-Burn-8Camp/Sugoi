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
          <img src="/images/sugoii_banner1.jpg" alt="bannerPic"  className='w-full'/>
        </div>
        <div>
          <img src="https://picsum.photos/1400/400?random=3" alt="fakePic"  className='w-full'/>
        </div>
        <div>
          <img src="https://picsum.photos/1400/400?random=4" alt="fakePic"  className='w-full'/>
        </div>
      </Slider>
    </div>
  );
  
}
export default BannerSlider
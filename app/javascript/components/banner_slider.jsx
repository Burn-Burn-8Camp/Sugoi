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
          <img src="/images/sugoii_banner1.jpg" alt="bannerPic1"  className='w-full'/>
        </div>
        <div>
          <img src="/images/sugoii_banner2.jpg" alt="bannerPic2"  className='w-full'/>
        </div>
        <div>
          <img src="/images/sugoii_banner3.jpg" alt="bannerPic3"  className='w-full'/>
        </div>
      </Slider>
    </div>
  );
  
}
export default BannerSlider
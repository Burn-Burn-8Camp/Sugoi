namespace :coupons do
  desc "Generate fake coupons"
  task :fake => :environment do
    coupon_list = [
      { name: "情人節抵用券", value: 50, description: "折抵50元" },
      { name: "情人節抵用券", value: 100, description: "折抵100元" },
      { name: "購物節抵用券", value: 150, description: "折抵150元" },
      { name: "購物節抵用券", value: 200, description: "折抵200元" },
      { name: "購物節抵用券", value: 10, description: "折抵10元" },
      { name: "購物節抵用券", value: 10, description: "折抵10元" }
    ]

    coupon_list.each{ |coupon|
      coupon = Coupon.create(coupon)        
    }
    p "created 6 coupons"
  end
end
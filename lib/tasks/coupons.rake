namespace :coupons do
  desc "Generate fake coupons"
  task :real => :environment do
    coupon_list = [
      { name: "Sugoii手作市集抵用券", value: 50, description: "折抵50元" },
      { name: "Sugoii手作市集抵用券", value: 50, description: "折抵50元" },
      { name: "Sugoii手作市集抵用券", value: 100, description: "折抵100元" },
      { name: "聖誕禮物祭抵用券", value: 50, description: "折抵50元" },
      { name: "聖誕禮物祭抵用券", value: 50, description: "折抵50元" },
      { name: "聖誕禮物祭抵用券", value: 100, description: "折抵100元" }
    ]

    coupon_list.each{ |coupon|
      coupon = Coupon.create(coupon)        
    }
    p "created 6 coupons"
  end
end
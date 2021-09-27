module UsersHelper
  def now_rank_icon(accumulated_amount)
    if accumulated_amount <= 2000 
      "<i class='far fas fa-award text-red-300'></i>"
    elsif accumulated_amount < 20000
      "<i class='fas fa-trophy text-blue-200'></i>"
    elsif accumulated_amount >= 20000
      "<i class='fas fa-crown text-yellow-500'></i>" 
    end      
  end

  def up_rank_icon(accumulated_amount)
    if accumulated_amount <= 2000
      "<i class='fas fa-trophy text-blue-200'></i>"
    elsif accumulated_amount < 20000
      "<i class='fas fa-crown text-yellow-500'></i>"
    end 
  end
  #判斷現在總消費金額的icon之後顯示下一等級的icon

  def check_favorite_item(favorite_items)
    if favorite_items
      if favorite_items.length != 0
        "<span id='heart' class='text-red-400'><i class='fas fa-heart'></i></span>".html_safe
      else
        "<span id='heart' class='text-gray-300'><i class='fas fa-heart'></i></span>".html_safe
      end
    end
  end

  def user_favorite_items(user)
    if user  
      user.favorite_items.length
    else
      o
    end
  end

  def about_feild?(user)
    whiteList = ['self_about', 'self_blog', 'self_web', 'life_shopping', 'life_design']
    whiteList.any? { |field| user[field].present? }
  end

  def filled_fields(user)
    whiteList = ['self_about', 'self_blog', 'self_web', 'life_shopping', 'life_design']
    filled_fields_array = []
    whiteList.each do |field| 
      if user[field].present? 
        field_hash = {}
        field_hash['title'] = field
        field_hash['content'] = user[field]
        filled_fields_array.push(field_hash)
      end
    end
    filled_fields_array
  end

  def transfer_title(title)
    transfer_content = {
      'self_about': '你是怎樣的一個人',
      'self_blog': '部落格',
      'self_web': '個人網站',
      'life_shopping': '你喜歡什麼東西、平常愛買些什麼',
      'life_design':  '愛逛的市集、設計師、老屋聚落'
    }
    transfer_content[title.to_sym]
  end
end
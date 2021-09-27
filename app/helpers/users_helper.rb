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
end
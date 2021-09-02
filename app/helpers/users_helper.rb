module UsersHelper
  def now_rank_icon(accumulated_amount)
    if accumulated_amount <= 2000
        # content_tag()  
      "<i class='far fas fa-award text-6xl text-red-600'></i>"
    elsif accumulated_amount <= 10000
      "<i class='fas fa-medal'></i>"
    elsif accumulated_amount >= 20000
      "<i class='fas fa-trophy'></i>" 
    end      
  end

  def up_rank_icon(accumulated_amount)
    if accumulated_amount <= 2000
      "<i class='fas fa-medal'></i>"
    elsif accumulated_amount >= 10000
      "<i class='fas fa-trophy'></i>"
    end 
  end

  def user_rank(accumulated_amount)
    if accumulated_amount <= 2000
      "白銀會員"
    elsif accumulated_amount <= 10000
      "尊貴會員"
    elsif accumulated_amount >= 20000
     
    end
  end

  def up_user_rake(accumulated_amount)
    if accumulated_amount <= 2000
      "一般會員"      
    elsif accumulated_amount <= 10000
      "白銀會員"
    elsif accumulated_amount >= 20000
      "尊貴會員"  
    end
  end
end

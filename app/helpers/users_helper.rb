module UsersHelper
  def now_rank_icon(rank_name)
    if rank_name == "一般會員"
        # content_tag()  
      "<i class='far fas fa-award text-6xl text-red-600'></i>"
    elsif rank_name == "白銀會員"
      "<i class='fas fa-medal'></i>"
    elsif rank_name == "尊貴會員"
      "<i class='fas fa-trophy'></i>" 
    end      
  end

  def up_rank_icon(rank_name)
    if rank_name == "一般會員"
      "<i class='fas fa-medal'></i>"
    elsif rank_name == "白銀會員"
      "<i class='fas fa-trophy'></i>"
    end 
  end

  def user_rank(rank_name)
    if rank_name == "一般會員"
      "白銀會員"
    elsif rank_name == "白銀會員"
      "尊貴會員"
    end
end
end

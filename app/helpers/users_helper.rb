module UsersHelper
  def now_rank_icon(accumulated_amount)
    if accumulated_amount <= 2000
        # content_tag()  
      "<i class='far fas fa-award text-6xl text-red-600'></i>"
    elsif accumulated_amount < 20000
      "<i class='fas fa-medal'></i>"
    elsif accumulated_amount >= 20000
      "<i class='fas fa-trophy'></i>" 
    end      
  end
  #判斷現在的總消費金額之後回傳的icon

  def up_rank_icon(accumulated_amount)
    if accumulated_amount <= 2000
      "<i class='fas fa-medal'></i>"
    elsif accumulated_amount < 20000
      "<i class='fas fa-trophy'></i>"
    end 
  end
  #判斷現在總消費金額的icon之後顯示下一等級的icon

  def user_rank(accumulated_amount)
    if accumulated_amount <= 2000
      "白銀會員"
    elsif accumulated_amount < 20000
      "尊貴會員"
    end
  end
  #顯示下一階段可升級成甚麼會員

  def now_user_rank(accumulated_amount)
    if accumulated_amount <= 2000
      "一般會員"      
    elsif accumulated_amount < 20000
      "白銀會員"
    elsif accumulated_amount >= 20000
      "尊貴會員"  
    end
  end
  #判斷現在的會員等級

  def still_need(accumulated_amount)
    if accumulated_amount < 2000
      2000 - accumulated_amount
    elsif accumulated_amount < 20000 
      20000 - accumulated_amount
    end
  end
  #判斷要完成任務還差多少消費金額
end

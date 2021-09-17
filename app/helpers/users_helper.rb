module UsersHelper
  def now_rank_icon(accumulated_amount)
    if accumulated_amount <= 2000 
      "<i class='far fas fa-award '></i>"
    elsif accumulated_amount < 20000
      "<i class='fas fa-trophy text-gray-500'></i>"
    elsif accumulated_amount >= 20000
      "<i class='fas fa-trophy'></i>" 
    end      
  end

  def up_rank_icon(accumulated_amount)
    if accumulated_amount <= 2000
      "<i class='fas fa-trophy text-gray-500'></i>"
    elsif accumulated_amount < 20000
      "<i class='fas fa-crown text-yellow-500'></i>"
    end 
  end
end
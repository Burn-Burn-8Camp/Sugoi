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
      #判斷現在的總消費金額之後回傳的icon
    
      def up_rank_icon(accumulated_amount)
        if accumulated_amount <= 2000
          "<i class='fas fa-trophy text-gray-500'></i>"
        elsif accumulated_amount < 20000
          "<i class='fas fa-crown text-yellow-500'></i>"
        end 
      end
      #判斷現在總消費金額的icon之後顯示下一等級的icon
end
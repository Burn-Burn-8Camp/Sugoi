class UsersController < ApplicationController
    before_action  :authenticate_user!

    def edit
        
    end

    def profile
      p "========"
      p current_user
      p "========"
    end
      # def home

    # end    
    # def show

    # end
    # private
    # def check_rank
    #     consume = current_user.orders.map{|order| 
    #         order.total......}
    #     if consume > 10000
    #         current_user.rank = 'sliver'
    #     end
    # end
end

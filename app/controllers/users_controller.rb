class UsersController < ApplicationController
    before_action  :authenticate_user!
    def index
      @user = User.all
    end
    def edit
      @user = User.find(params[:id])
    end

    def profile
    end
end

class UsersController < ApplicationController
    before_action  :authenticate_user!

    def member_centre
    end

    def basic
        @user = current_user
    end

    def user_params
        params.require(:user).permit(:nickname, :email, :gender, :birth, :country, :image)
    end

    def about_me
        @user = current_user
    end
end

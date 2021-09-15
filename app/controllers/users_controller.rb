class UsersController < ApplicationController
  before_action  :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_member_index_path ,notice: "修改成功"
    else
      render :edit
    end
  end

  def create
  end

  def about
    @user = current_user
  end

  def profile
  end

  def buy_order
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :gender, :date, :country, :image)
  end
end

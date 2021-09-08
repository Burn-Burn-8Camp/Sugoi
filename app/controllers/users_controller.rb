class UsersController < ApplicationController
  before_action  :authenticate_user!
    # before_action :current_user
  def index
    @user = current_user
  end

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
  # def user_params 
  #   params.require(:user).permit(:self_blog, :self_about, :self_web, :life_shopping:life_design )
  # end
end

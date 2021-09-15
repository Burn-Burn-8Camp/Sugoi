class UsersController < ApplicationController
  before_action  :authenticate_user!
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
end

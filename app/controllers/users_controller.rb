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
    @user = User.role != "seller"
		if @user.save
			redirect_to root_path, notice: '感謝您的申請'
		else
			render :new, notice: '請重新填寫'
		end
  end

  def about
    @user = current_user
  end

  def profile
  end
end

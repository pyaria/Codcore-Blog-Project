class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new allowed_user_params

    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def allowed_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end

class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[ new create ]
  before_action :set_user, only: %i[ show ]

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: t('.success')
    else
      flash.now[:error] = t('.fail')
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

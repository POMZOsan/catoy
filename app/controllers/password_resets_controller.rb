class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  before_action :ensure_nomal_user, only: %i[ create ]

  def new; end

  def create
    @user = User.find_by_email(params[:email])
    @user.deliver_reset_password_instructions! if @user
    redirect_to login_path, success: t('.success')
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: t('.success')
    else
      flash.now[:error] = t('.fail')
      render :edit
    end
  end

  private

  def ensure_nomal_user
    if params[:email] == 'guest@example.com'
      redirect_to login_path, warning: 'ゲストユーザーのパスワード再設定はできません'
    end
  end
end

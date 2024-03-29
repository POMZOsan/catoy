class ProfilesController < ApplicationController
  before_action :set_user, only: %i[ edit update destroy ]
  before_action :ensure_nomal_user, only: %i[ edit update destroy ]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: t('defaults.message.update', item: User.model_name.human)
    else
      flash.now[:error] = t('defaults.message.fail_update', item: User.model_name.human)
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to root_path, info: t('.destroy_acount')
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :avatar)
  end

  def ensure_nomal_user
    if current_user.guest?
      redirect_to profile_path, warning: 'ゲストユーザーは編集・削除ができません！'
    end
  end
end

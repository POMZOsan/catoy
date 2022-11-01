class Admin::UsersController < Admin::BaseController
  before_action :set_search_form, only: %i[ index ]
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = @search_user.search.order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), success: t('defaults.message.update', item: User.model_name.human)
    else
      flash.now[:error] = t('defaults.message.fail_update', item: User.model_name.human)
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, success: t('defaults.message.destroy', item: User.model_name.human)
  end

  private

  def set_search_form
    @search_user = SearchUsersForm.new(search_params)
  end

  def search_params
    params.fetch(:q, {}).permit(:name, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :avatar, :role)
  end
end

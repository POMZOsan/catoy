class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if auth_params[:denied].present?
      redirect_to login_path, info: "#{provider.titleize}でのログインをキャンセルしました"
      return
    end

    if @user = login_from(provider)
      redirect_to root_path, success: "#{provider.titleize}でログインしました"
    else
      begin
        @user = create_from(provider)
        @user.download_and_attach_avatar(@user.profile_image)
        reset_session
        auto_login(@user)
        redirect_to root_path, success: "#{provider.titleize}でログインしました"
      rescue
        redirect_to root_path, error: "#{provider.titleize}でのログインに失敗しました"
      end
    end
  end

  private

  def auth_params
      params.permit(:code, :provider, :denied)
  end
end

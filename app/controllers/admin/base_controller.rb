class Admin::BaseController < ApplicationController
  before_action :check_admin
  layout 'admin/layouts/application'

  private

  def not_authenticated do
    redirect_to admin_login_path, warning: t('defaults.message.require_login')
  end

  def check_admin do
    redirect_to root_path, warning: t('defaults.message.not_authorized') unless current_user.admin?
  end
end

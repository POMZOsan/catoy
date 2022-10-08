class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :error
  before_action :require_login, :set_search_review_form

  private

  def not_authenticated
    redirect_to login_path, warning: t('defaults.message.require_login')
  end

  def set_search_review_form
    @search_review = SearchReviewsForm.new(search_review_params)
  end

  def search_review_params
    params.fetch(:q, {}).permit(:keyword, :category_name)
  end
end

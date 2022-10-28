class Admin::ReviewsController < Admin::BaseController
  def index
    @reviews = Review.all.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit
  end

  def update
  end

  def detroy
  end
end

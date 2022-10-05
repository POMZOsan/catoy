class ReviewsController < ApplicationController
  skip_before_action :require_login, only: %i[ index show ]
  before_action :set_review, only: %i[ edit destroy ]

  def index
    @reviews = Review.all.includes(:user, :favourites).order(created_at: :desc)
  end

  def favourites
    @favoured_reviews = current_user.favoured_reviews.includes(:user).order(created_at: :desc)
  end

  def new; end

  def show
    @review = Review.find(params[:id])
  end

  def edit; end

  def destroy
    @review.destroy!
    redirect_to reviews_path, success: t('defaults.message.destroy', item: Review.model_name.human)
  end

  private

  def set_review
    @review = current_user.reviews.find(params[:id])
  end
end

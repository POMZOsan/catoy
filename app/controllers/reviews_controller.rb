class ReviewsController < ApplicationController
  skip_before_action :require_login, only: %i[ index show ]
  before_action :set_review, only: %i[ edit update destroy ]

  def index
    @reviews = Review.all.includes(:user, :favourites).order(created_at: :desc)
  end

  def favourites
    @favoured_reviews = current_user.favoured_reviews.includes(:user).order(created_at: :desc)
  end

  def new
    @review = Review.new
  end

  def show
    @review = Review.find(params[:id])
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save_with_product(product_id: params.dig(:review, :product_id), product_type: params.dig(:review, :product_type))
      redirect_to review_path(@review), success: t('defaults.message.create', item: Review.model_name.human)
    else
      flash.now[:error] = t('defaults.message.fail_create', item: Review.model_name.human)
      render :new
    end
  end

  def edit; end

  def update
    @review.assign_attributes(review_params)
    if @review.save_with_product(product_id: params.dig(:review, :product_id), product_type: params.dig(:review, :product_type))
      redirect_to review_path(@review), success: t('defaults.message.update', item: Review.model_name.human)
    else
      flash.now[:error] = t('defaults.message.fail_update', item: Review.model_name.human)
      render :edit
    end
  end

  def destroy
    @review.destroy!
    redirect_to reviews_path, success: t('defaults.message.destroy', item: Review.model_name.human)
  end

  private

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :content, :rate, :image)
  end
end

class ReviewsController < ApplicationController
  skip_before_action :require_login, only: %i[ index show ]
  before_action :set_review, only: %i[ edit update destroy ]

  def index
    @reviews = Review.all.includes(:user).order(created_at: :desc)
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
      flash.now[:error] = t('defaults.message.fail_create')
      render :new
    end
  end

  def edit; end

  def update
    @review.assign_attributes(review_params)
    if @review.save_with_product(product_id: params.dig(:review, :product_id), product_type: params.dig(:review, :product_type))
      redirect_to review_path(@review), success: t('defaults.message.create', item: Review.model_name.human)
    else
      flash.now[:error] = t('defaults.message.fail_update')
      render :edit
    end
  end

  def destroy
  end

  private

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  # def which_product
  #   if params[:review][:cainz_id].present?
  #     @product = Cainz.find(params[:review][:cainz_id])
  #   elsif params[:review][:rakuten_id].present?
  #     @product = Rakuten.find(params[:review][:rakuten_id])
  #   else
  #     @product = 'no_product'
  #   end
  # end

  def review_params
    params.require(:review).permit(:title, :content, :rate, :image)
  end
end

class Api::ReviewsController < ApplicationController
  before_action :set_review, only: %i[ edit update ]

  def edit
    render json: @review, serializer: ReviewSerializer
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save_with_product(product_id: params[:product_id], product_type: params[:product_type])
      render json: @review
    else
      flash.now[:error] = t('defaults.message.fail_create', item: Review.model_name.human)
      render :new
    end
  end

  def update
    @review.assign_attributes(review_params)
    if @review.save_with_product(product_id: params[:product_id], product_type: params[:product_type])
      render json: @review
    else
      flash.now[:error] = t('defaults.message.fail_update', item: Review.model_name.human)
      render :edit
    end
  end

  private

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def review_params
    params.permit(:title, :content, :rate, :image)
  end
end

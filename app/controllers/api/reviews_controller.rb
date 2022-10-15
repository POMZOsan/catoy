class Api::ReviewsController < ApplicationController
  before_action :set_review, only: %i[ edit update ]

  def edit
    render json: @review, serializer: ReviewSerializer
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save_with_product(product_id: params[:product_id], product_type: params[:product_type])
      render json: { location: review_path(@review) }, status: :ok
    else
      render json: { errors: @review.errors.attribute_names.index_with {|key| @review.errors.full_messages_for(key)} }, status: :bad_request
    end
  end

  def update
    @review.assign_attributes(review_params_for_update)
    if @review.save_with_product(product_id: params[:product_id], product_type: params[:product_type])
      render json: { location: review_path(@review) }, status: :ok
    else
      render json: { errors: @review.errors.attribute_names.index_with {|key| @review.errors.full_messages_for(key)} }, status: :bad_request
    end
  end

  private

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def review_params
    params.permit(:title, :content, :rate, :image)
  end

  def review_params_for_update
    if @review.image.attached?
        image_path = url_for(@review.image)
      if image_path == params[:image]
        params.permit(:title, :content, :rate)
      else
        params.permit(:title, :content, :rate, :image)
      end
    else
      params.permit(:title, :content, :rate, :image)
    end
  end
end

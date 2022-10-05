class Api::ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save_with_product(product_id: params[:product_id], product_type: params[:product_type])
      render json: @review
    else
      flash.now[:error] = t('defaults.message.fail_create', item: Review.model_name.human)
      render :new
    end
  end

  private

  def review_params
    params.permit(:title, :content, :rate, :image)
  end
end

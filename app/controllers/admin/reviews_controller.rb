class Admin::ReviewsController < Admin::BaseController
  before_action :set_search_form, only: %i[ index ]
  before_action :set_review, only: %i[ show edit update destroy ]

  def index
    @reviews = @search_review.admin_search.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @review.update(review_params)
      redirect_to admin_review_path(@review), success: t('defaults.message.update', item: Review.model_name.human)
    else
      flash.now[:error] = t('defaults.message.fail_update', item: Review.model_name.human)
      render :edit
    end
  end

  def detroy
  end

  private

  def set_search_form
    @search_review = SearchReviewsForm.new(search_params)
  end

  def search_params
    params.fetch(:q, {}).permit(:title_or_content, :rate, :created_at_gteq, :created_at_lteq, :shop)
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :content, :rate, :image)
  end
end

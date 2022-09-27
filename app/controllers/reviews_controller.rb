class ReviewsController < ApplicationController
  skip_before_action :require_login, only: %i[ index show ]
  before_action :set_review, only: %i[ edit update destroy ]

  def index
    @reviews = Review.all.includes(:user).order(created_at: :desc)
  end

  def new
    @review = Review.new
  end

  def show; end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      which_product(@review) # 商品が登録されていないときのvalidationを追加する必要アリ
      redirect_to review_path(@review), success: t('defaults.message.create', item: Review.model_name.human)
    else
      flash.now[:error] = t('defaults.message.fail_create')
      render :new
    end
  end

  def edit; end

  def update
  end

  def destroy
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_cainz(id)
    @cainz = Cainz.find(id)
  end

  def set_rakuten(id)
    @rakuten = Rakuten.find(id)
  end

  def which_product(review)
    if params[:review][:cainz_id].present?
      set_cainz(params[:review][:cainz_id]).reviews << review
    elsif params[:review][:rakuten_id].present?
      set_rakuten(params[:review][:rakuten_id]).reviews << review
    end
  end

  def review_params
    params.require(:review).permit(:title, :content, :rate, :image)
  end
end

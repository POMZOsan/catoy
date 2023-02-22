class RankingsController < ApplicationController
  skip_before_action :require_login, only: %i[ index ranked_reviews ]

  def index; end

  def ranked_reviews
    case params[:toy_shop]
      when 'カインズホーム' then @toy = Cainz.find(params[:toy_id])
      when '楽天24' then @toy = Rakuten.find(params[:toy_id])
    end
    @toy
    @reviews = @toy.reviews.includes(:user, :favourites).order(created_at: :desc).page(params[:page])
  end
end

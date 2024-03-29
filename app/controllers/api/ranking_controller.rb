class Api::RankingController < ApplicationController
  skip_before_action :require_login, only: %i[ active gentle review ]

  def active
    toys_active_cat_loved = ReviewBlock.toys_ranking(character: 0)
    render json: toys_active_cat_loved, status: :ok
  end

  def gentle
    toys_gentle_cat_loved = ReviewBlock.toys_ranking(character: 1)
    render json: toys_gentle_cat_loved, status: :ok
  end

  def review
    render json: { location: ranked_reviews_rankings_path }, status: :ok
  end
end

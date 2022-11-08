class Api::RankingController < ApplicationController
  skip_before_action :require_login, only: %i[ active gentle ]

  def active
    @toys_active_cat_loved = ReviewBlock.toys_ranking(character: 0)
    render json: @toys_active_cat_loved, each_serializer: ReviewBlockSerializer
  end

  def gentle
    @toys_gentle_cat_loved = ReviewBlock.toys_ranking(character: 1)
    render json: @toys_gentle_cat_loved, each_serializer: ReviewBlockSerializer
  end
end

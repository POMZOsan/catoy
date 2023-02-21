class RankingsController < ApplicationController
  skip_before_action :require_login, only: %i[ index ranked_reviews ]

  def index; end

  def ranked_reviews
  end
end

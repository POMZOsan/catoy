class Api::RakutenController < ApplicationController
  def index
    @rakuten = Rakuten.all
    render json: @rakuten, each_serializer: RakutenSerializer
  end
end

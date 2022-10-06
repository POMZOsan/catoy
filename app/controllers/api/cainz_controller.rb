class Api::CainzController < ApplicationController
  def index
    @cainz = Cainz.all
    render json: @cainz, each_serializer: CainzSerializer
  end
end

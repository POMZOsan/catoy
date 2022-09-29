class FavouritesController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    current_user.favoured(@review)
  end

  def destroy
    @review = current_user.favourites.find(params[:id]).review
    current_user.remove_favourite(@review)
  end
end

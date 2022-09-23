class ReviewsController < ApplicationController
  skip_before_action :require_login, only: %i[ index show ]

  def index
  end

  def new
  end

  def show
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

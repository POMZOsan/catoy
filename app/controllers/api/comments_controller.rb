class Api::CommentsController < ApplicationController
  before_action :set_review, only: %i[ index ]

  def index
    @comments = @review.comments.all.includes(:user).order(created_at: :desc)
    render json: @comments
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors, status: :bad_request
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    render json: @comment
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(review_id: params[:review_id])
  end
end

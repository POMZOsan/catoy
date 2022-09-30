class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(review_id: params[:review_id])
  end
end

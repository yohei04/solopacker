class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    flash[:alert] = "Comment can't be empty" unless @comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy!
    flash[:notice] = 'Comment deleted!'
    redirect_back(fallback_location: root_path)
  end

  private

    def comment_params
      params.permit(:content, :recruit_id)
    end
end

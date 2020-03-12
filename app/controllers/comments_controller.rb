class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    if !@comment.save
      flash[:alert] = "Comment coudn'\t create!"
    end
    redirect_back(fallback_location: root_path)
  end

  private

    def comment_params
      params.permit(:content, :recruit_id)
    end
end

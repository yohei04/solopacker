class CommentsController < ApplicationController
  def create
    @recruit = Recruit.find(params[:recruit_id])
    comment = @recruit.comments.build(comment_params)
    comment.user_id = current_user.id
    respond_to do |format|
      if comment.save
        format.js
      else
        format.html { render 'recruits/show' }
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    respond_to do |format|
      @comment.destroy!
      format.js
    end
  end

  private

    def comment_params
      params.permit(:content)
    end
end

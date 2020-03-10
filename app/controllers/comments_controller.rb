class CommentsController < ApplicationController
  def create
  end

  def update
  end

  def destroy
  end

  privete
    def comment_params
      params.require(:comment).permit(:content)
    end
end

class JoinsController < ApplicationController
  def create
    @join = current_user.joins.build(join_params)
    @recruit = Recruit.find_by(id: params[:recruit_id])
    if current_user.id == @recruit.user_id
      return
    elsif current_user.already_commented?(@recruit) && current_user.id != @recruit.user_id
      @join.save
      flash[:notice] = 'You join this recruit!'
    else
      flash[:alert] = 'Please comment first'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @join = current_user.joins.find_by(recruit_id: params[:recruit_id])
    @join.destroy!
    redirect_back(fallback_location: root_path)
  end

  private

    def join_params
      params.permit(:recruit_id)
    end
end

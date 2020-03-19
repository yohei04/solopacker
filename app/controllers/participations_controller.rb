class ParticipationsController < ApplicationController
  def create
    @participation = current_user.participations.build(participation_params)
    @recruit = Recruit.find_by(id: params[:recruit_id])
    if current_user.id == @recruit.user_id
      flash[:alart] = 'You are owner'
    elsif current_user.already_commented?(@recruit) && current_user.id != @recruit.user_id
      @participation.save
      flash[:notice] = 'You joined this recruit!'
    else
      flash[:alert] = 'Please comment first'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @participation = current_user.participations.find_by(recruit_id: params[:recruit_id])
    @participation&.destroy!
    redirect_back(fallback_location: root_path)
  end

  private

    def participation_params
      params.permit(:recruit_id)
    end
end

class ParticipationsController < ApplicationController
  include ParticipationsHelper

  def create
    # @participation = current_user.participations.build(participation_params)
    @recruit = Recruit.find_by(id: params[:recruit_id])
    if permit_participate?
      current_user.participate(@recruit)
      flash[:notice] = 'You joined this recruit!'
    else
      flash[:alert] = current_user.id == @recruit.user_id ? 'You are owner' : 'Please comment first'
    end
    respond_to do |format|
      format.html { redirect_to @recruit }
      format.js
    end
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    # @participation = current_user.participations.find_by(recruit_id: params[:recruit_id])
    # redirect_back(fallback_location: root_path)
    @recruit = Recruit.find(params[:recruit_id])
    current_user.unparticipate(@recruit)
    respond_to do |format|
      format.html { redirect_to @recruit }
      format.js
    end
  end

  private

    def participation_params
      params.permit(:recruit_id)
    end

    def permit_participate?
      current_user.commented?(@recruit) && current_user.id != @recruit.user_id
    end
end

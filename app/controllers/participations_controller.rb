class ParticipationsController < ApplicationController
  
  def create
    @recruit = Recruit.find(params[:recruit_id])
    if current_user.permit_participate?(@recruit)
      current_user.participate(@recruit)
    else
      flash.now[:alert] = current_user.id == @recruit.user_id ? 'You are owner' : 'Please comment first'
    end
  end

  def destroy
    @recruit = current_user.participated_recruits.find(params[:recruit_id])
    current_user.unparticipate(@recruit)
  end
end

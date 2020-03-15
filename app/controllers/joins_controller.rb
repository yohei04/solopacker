class JoinsController < ApplicationController
  def create
    @join = current_user.joins.create(join_params)
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

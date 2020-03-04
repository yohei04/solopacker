class RecruitController < ApplicationController
  def index; end

  def show; end

  def new
    @recruit = Recruit.new
  end

  def create
    @recruit = current_user.recruits.build(recruit_params)
    if @recruit.save
      flash[:notice] = 'Recruit created!'
      redirect_to root_path
    else
      render new_recruit_path
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

    def recruit_params
      params.require(:recruit).permit(:date_time, :hour, :country, :city, :title, :content)
    end
end

class RecruitsController < ApplicationController
  def show
    @recruit = Recruit.find(params[:id])
  end

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

  def edit
    @recruit = Recruit.find(params[:id])
  end

  def update
    @recruit = Recruit.find(params[:id])
    if @recruit.update!(recruit_params)
      redirect_to root_path, notice: 'Recruit updated!'
    else
      render edit_recruit_path
    end
  end

  def destroy
    recruit = Recruit.find(params[:id])
    recruit.destroy
    redirect_to root_path, notice: 'Recruit deleted!'
  end

  private

    def recruit_params
      params.require(:recruit).permit(:date_time, :hour, :country, :city, :title, :content)
    end
end

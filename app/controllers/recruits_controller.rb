class RecruitsController < ApplicationController
  before_action :profile_blank_check, only: %i[new create]

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
      render :new
    end
  end

  def edit
    @recruit = Recruit.find(params[:id])
  end

  def update
    @recruit = Recruit.find(params[:id])
    if @recruit.update(recruit_params)
      flash[:notice] = 'Recruit updated!'
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    recruit = Recruit.find(params[:id])
    recruit.destroy!
    flash[:notice] = 'Recruit deleted!'
    redirect_to root_path
  end

  private

    def recruit_params
      params.require(:recruit).permit(:date_time, :hour, :country, :city, :title, :content)
    end

    # beforeフィルター
    def profile_blank_check
      if [current_user.gender, current_user.origin, current_user.current_country,
          current_user.language_1, current_user.introduce].any?(&:blank?)
        flash[:alert] = 'Please fill out your profile'
        redirect_to edit_users_profile_path(current_user)
      end
    end
end

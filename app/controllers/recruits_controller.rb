class RecruitsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update, :destory]
  
  def show
    @recruit = Recruit.find(params[:id])
  end

  def new
    if current_user.gender.blank? || current_user.origin.blank? || current_user.current_country.blank? || current_user.language_1.blank? || current_user.introduce.blank?
      flash[:alert] = 'Please fill out your profile'
      redirect_to edit_users_profile_path(current_user)
    else
      @recruit = Recruit.new
    end
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
      flash[:notice] = 'Recruit updated!'
      redirect_to root_path
    else
      render edit_recruit_path
    end
  end

  def destroy
    recruit = Recruit.find(params[:id])
    recruit.destroy
    flash[:notice] = 'Recruit deleted!'
    redirect_to root_path
  end

  private

    def recruit_params
      params.require(:recruit).permit(:date_time, :hour, :country, :city, :title, :content)
    end
end

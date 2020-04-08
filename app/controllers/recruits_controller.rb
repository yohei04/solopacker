class RecruitsController < ApplicationController
  before_action :authenticate_user!, except: [:map]

  include ProfilesHelper
  include RecruitHelper

  def show
    @recruit = Recruit.find(params[:id])
    @comment = Comment.new
    @participation = Participation.new
  end

  def new
    if profile_blank_check?
      flash[:alert] = 'Please fill out your profile'
      redirect_to edit_users_profile_path(current_user)
    else
      @recruit = Recruit.new
    end
  end

  def create
    @recruit = current_user.recruits.build(recruit_params)
    if profile_blank_check?
      flash[:alert] = 'Please fill out your profile'
      redirect_to edit_users_profile_path(current_user)
    elsif @recruit.save
      flash[:notice] = 'Recruit created!'
      redirect_to @recruit
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
      redirect_to @recruit
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

  def map
    # @recruits_json = Recruit.all.to_json(only: [:id, :title, :city, :latitude, :longitude])
    around = (-0.1..0.1).step(0.001).map(&:itself)
    @recruits_json = Recruit.includes(user: { image_attachment: :blob }).map do |r|
      # if r.user.image.attached?
      {
        id: r.id,
        title: r.title,
        country: country_name(r.country),
        city: r.city,
        # 同じ都市だと画像が完全に被ってしまうのでちょっとずらした
        lat: latitude(r.city) + around.sample,
        lng: longitude(r.city) + around.sample,
        user: {
          image: Rails.application.routes.url_helpers.rails_blob_path(r.user.image, only_path: true)
        }
      }
      # end
    end.to_json
  end

  private

    def recruit_params
      params.require(:recruit).permit(:date_time, :hour, :country, :city, :title, :content)
    end
end

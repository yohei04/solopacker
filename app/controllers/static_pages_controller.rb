class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def home
    respond_to do |format|
      if params[:q].blank?
        @q = Recruit.upcoming.includes(user: { image_attachment: :blob }).ransack(country_cont: current_user.current_country)
      else
        @q = Recruit.upcoming.includes(user: { image_attachment: :blob }).ransack(params[:q])
      end
      @recruits = @q.result(distinct: true).page(params[:page]).per(6)
      format.html
      format.js
    end
    gon.first_popular_country = Recruit.popular_countries[0]
    gon.current_user_origin = current_user.origin
    
    # gon.users = User.all
  end

  def about; end

  def rate; end
end

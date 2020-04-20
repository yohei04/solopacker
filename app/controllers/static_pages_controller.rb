class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def home
    if params[:q].blank?
      @q = Recruit.happen_recent.includes(user: { image_attachment: :blob }).ransack(country_cont: current_user.current_country)
    else
      @q = Recruit.happen_recent.includes(user: { image_attachment: :blob }).ransack(params[:q])
    end
    @recruits = @q.result(distinct: true).page(params[:page]).per(6)
  end

  def about; end

  def rate; end
end

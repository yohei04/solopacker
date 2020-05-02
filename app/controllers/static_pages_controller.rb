class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def home
    return if current_user.nil?
    respond_to do |format|
      @q = if params[:q].blank?
             Recruit.upcoming.includes(user: { image_attachment: :blob }).ransack(country_cont: current_user.current_country)
           else
             Recruit.upcoming.includes(user: { image_attachment: :blob }).ransack(params[:q])
           end
      @recruits = @q.result(distinct: true).page(params[:page]).per(6)
      format.html
      format.js
    end
    gon.current_country = current_user.current_country
    gon.next_country = current_user.uniq_feature_mix_recruits[0]&.country
    gon.origin = current_user.origin
    # gon.popular_countries = Recruit.popular_countries.first(3)
  end

  def about; end

  def rate; end
end

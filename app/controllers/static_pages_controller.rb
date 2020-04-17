class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def home
    @q = Recruit.includes(user: { image_attachment: :blob }).ransack(params[:q])
    @recruits = @q.result(distinct: true).page(params[:page]).per(6).create_recent
  end

  def rate
  end
end

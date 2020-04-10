class StaticPagesController < ApplicationController
  include RateApi

  before_action :authenticate_user!, except: [:home]

  def home
    @q = Recruit.includes(user: { image_attachment: :blob }).ransack(params[:q])
    @recruits = @q.result(distinct: true).page(params[:page]).per(6).recent
  end

  def rate
    @base_currency = currency(current_user.origin)
    @target_currency = currency(current_user.current_country)
    @exchange_rate = exchange_rate(@base_currency, @target_currency)
  end
end

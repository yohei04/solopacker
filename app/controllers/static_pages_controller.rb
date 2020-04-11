class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def home
    @q = Recruit.includes(user: { image_attachment: :blob }).ransack(params[:q])
    @recruits = @q.result(distinct: true).page(params[:page]).per(6).recent
  end

  def rate
    include RateApi
    # @recruits = current_user.recruits
    # @base_currency = currency(current_user.origin)
    # @target_currency = currency(current_user.current_country)
    # @exchange_rate = exchange_rate(@base_currency, @target_currency)
    # redirect_to rate_path
  end
end

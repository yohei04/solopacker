class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def home
    @q = Recruit.ransack(params[:q])
    @recruits = @q.result(distinct: true).page(params[:page]).per(6).recent
  end
end

class StaticPagesController < ApplicationController
  def home
    # @recruits = Recruit.all.recent
    @q = Recruit.ransack(params[:q])
    @recruits = @q.result(distinct: true).page(params[:page]).per(24)
  end
end

class StaticPagesController < ApplicationController
  def home
    @recruits = Recruit.all.recent
  end
end

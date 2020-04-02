class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def home
    @q = Recruit.ransack(params[:q])
    @recruits = @q.result(distinct: true).page(params[:page]).per(6).recent
    @recruits_json = Recruit.all.to_json(only: [:title, :latitude, :longitude])
  end

  def map
    # これでmap.js.erbで、経度緯度情報が入った@latlngを使える。
    @recruits = Recruit.all
    # results = Geocoder.search(Recruit.second.country)
    # @latlng = results.first.coordinates
    # binding.pry
    # respond_to以下の記述によって、
    # remote: trueのアクセスに対して、
    # map.js.erbが変えるようになります。
    respond_to do |format|
      format.js
    end
  end
end

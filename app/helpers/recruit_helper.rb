module RecruitHelper

  def profile_blank_check?
    [current_user.gender, current_user.origin, current_user.current_country,
      current_user.language_1, current_user.introduce].any?(&:blank?)
  end

  # # Geocoderでcityから経度と緯度取得
  def latitude(city)
    Geocoder.search(city).first.coordinates[0]
  end

  def longitude(city)
    Geocoder.search(city).first.coordinates[1]
  end

end

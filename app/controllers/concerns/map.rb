module Map
  extend ActiveSupport::Concern
  include ProfilesHelper

  def around
    (-0.1..0.1).step(0.001).map(&:itself)
  end

  def lat_lng(city, country)
    Geocoder.search("#{city}, #{country}").first.coordinates
  end

  # 全ての募集のjson
  def feature_recruits_json
    Recruit.upcoming.includes(user: { image_attachment: :blob }).map do |r|
      user_image_path = if r.user.image.attached?
                          Rails.application.routes.url_helpers.rails_blob_path(r.user.image, only_path: true)
                        else
                          DEFAULT_IMAGE_PATH
                        end
      {
        id: r.id,
        title: r.title,
        country: country_name(r.country),
        city: r.city,
        # 同じ都市だと画像が完全に被ってしまうのでちょっとずらした
        lat: lat_lng(r.city, r.country)[0] + around.sample,
        lng: lat_lng(r.city, r.country)[1] + around.sample,
        user: {
          image: user_image_path
        }
      }
    end.to_json
  end

  # タイプ別の募集(ユーザーが募集した募集と参加した募集)のjson
  def recruits_json(recruits_type, pin_type)
    JSON.parse(recruits_type.map do |r|
      {
        id: r.id,
        title: r.title,
        country: country_name(r.country),
        city: r.city,
        # 同じ都市だと画像が完全に被ってしまうのでちょっとずらす
        lat: lat_lng(r.city, r.country)[0] + around.sample,
        lng: lat_lng(r.city, r.country)[1] + around.sample,
        pin: pin_type
      }
    end.to_json)
  end

  # タイプ別の募集の集合のjson
  def mixed_recruits_json(a_recruits_json, b_recruits_json)
    JSON.generate(a_recruits_json.concat(b_recruits_json))
  end
end

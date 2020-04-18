module Map
  extend ActiveSupport::Concern
  include ProfilesHelper

  def around
    (-0.1..0.1).step(0.001).map(&:itself)
  end

  def lat_lng(city)
    Geocoder.search(city).first.coordinates
  end

  # 全ての募集のjson
  def recruits_all_json
    Recruit.all.includes(user: { image_attachment: :blob }).map do |r|
      if(r.user.image.attached?)
        user_image_path = Rails.application.routes.url_helpers.rails_blob_path(r.user.image, only_path: true)
      else
        user_image_path = "/packs/media/images/default_other-c1f1adec8f43fef3927559d1394e0e4c.png";
      end
      {
        id: r.id,
        title: r.title,
        country: country_name(r.country),
        city: r.city,
        # 同じ都市だと画像が完全に被ってしまうのでちょっとずらした
        lat: lat_lng(r.city)[0] + around.sample,
        lng: lat_lng(r.city)[1] + around.sample,
        user: {
          image: user_image_path
        }
      }
    end.to_json
  end

  # タイプ別の募集(ユーザーが募集した募集と参加した募集)
  def recruits_json(recruits_type, pin_type)
    JSON.parse(recruits_type.map do |r|
      {
        id: r.id,
        title: r.title,
        country: country_name(r.country),
        city: r.city,
        # 同じ都市だと画像が完全に被ってしまうのでちょっとずらす
        lat: lat_lng(r.city)[0] + around.sample,
        lng: lat_lng(r.city)[1] + around.sample,
        pin: pin_type
      }
    end.to_json)
  end

  # タイプ別の募集の集合のjson
  def mixed_recruits_json(a_recruits_json, b_recruits_json)
    JSON.generate(a_recruits_json.concat(b_recruits_json))
  end
end

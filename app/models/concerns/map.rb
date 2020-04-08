module Map

  extend ActiveSupport::Concern
  include ProfilesHelper

  around = (-0.1..0.1).step(0.001).map(&:itself)
  def lat_lng(city)
    lat_lng = Geocoder.search(city).first.coordinates
  end
  
  def recruits_all_json
    @recruits_json = Recruit.includes(user: { image_attachment: :blob }).map do |r|
      # if r.user.image.attached?
      {
        id: r.id,
        title: r.title,
        country: country_name(r.country),
        city: r.city,
        # 同じ都市だと画像が完全に被ってしまうのでちょっとずらした
        lat: lat_lng(r.city)[0] + around.sample,
        lng: lat_lng(r.city)[1] + around.sample,
        user: {
          image: Rails.application.routes.url_helpers.rails_blob_path(r.user.image, only_path: true)
        }
      }
    end.to_json
  end
  
  def recruits_json(user_recruits, pin_type)
    around = (-0.1..0.1).step(0.001).map(&:itself)
    JSON.parse(user_recruits.map do |r|
      lat_lng = Geocoder.search(r.city).first.coordinates
      {
        id: r.id,
        title: r.title,
        country: country_name(r.country),
        city: r.city,
        # 同じ都市だと画像が完全に被ってしまうのでちょっとずらす
        lat: lat_lng[0] + around.sample,
        lng: lat_lng[1] + around.sample,
        pin: pin_type
      }
    end.to_json)
  end
  

  def mixed_recruits_json(a_recruits, b_recruits)
    a_recruits = recruits_json(user_recruits, pin_type)
    b_recruits = recruits_json(user_recruits, pin_type)
    a_recruits << b_recruits
    mixed_recruits = a_recruits.flatten
    JSON.generate(mixed_recruits)
  end



  #   participated_recruits_json = JSON.parse(user.participated_recruits.map do |r|
  #     {
  #       id: r.id,
  #       title: r.title,
  #       country: country_name(r.country),
  #       city: r.city,
  #       lat: latitude(r.city),
  #       lng: longitude(r.city),
  #       type: 'participate_pin'
  #     }
  #   end.to_json)
  #   hosted_recruits_json << participated_recruits_json
  #   hp = hosted_recruits_json.flatten
  #   JSON.generate(hp)
  # end
  
end

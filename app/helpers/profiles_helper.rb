module ProfilesHelper
  # 国コードを国名に変更
  def country_name(country_code)
    return if ISO3166::Country[country_code].blank?

    c = ISO3166::Country[country_code]
    c.translations[I18n.locale.to_s] || c.name
  end

  # 国コードを国旗に変更
  def country_flag(country_code)
    return if country_code.blank?

    c = Country[country_code]
    c.emoji_flag
  end

  # ユーザーが募集した募集と参加した募集
  def hp_json
    user = User.find(params[:id])
    hosted_recruits_json = JSON.parse(user.recruits.map{|r|
      {
        id: r.id,
        title: r.title,
        country: country_name(r.country),
        city: r.city,
        # 同じ都市だと画像が完全に被ってしまうのでちょっとずらした
        lat: latitude(r.city) + ((- 0.1..0.1).step(0.001).map(&:itself)).sample,
        lng: longitude(r.city) + (( -0.1..0.1).step(0.001).map(&:itself)).sample,
        type: 'host_pin'
      }
    }.to_json)
    participated_recruits_json = JSON.parse(user.participated_recruits.map{|r|
      {
        id: r.id,
        title: r.title,
        country: country_name(r.country),
        city: r.city,
        lat: latitude(r.city),
        lng: longitude(r.city),
        type: 'participate_pin'
      }
    }.to_json)
    hosted_recruits_json << participated_recruits_json
    hp = hosted_recruits_json.flatten
    JSON.generate(hp)
  end
end

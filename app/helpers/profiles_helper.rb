module ProfilesHelper
  def age(user)
    return if user.date_of_birth.nil?

    (Time.zone.today.strftime('%Y%m%d').to_i - user.date_of_birth&.strftime('%Y%m%d').to_i) / 10_000
  end

  # 国コードを国名に変更
  def country_name(country_code)
    c = ISO3166::Country[country_code]
    c.translations[I18n.locale.to_s] || c.name
  end
end

module ProfilesHelper
  # 国コードを国名に変更
  def country_name(country_code)
    return if country_code.blank?

    c = ISO3166::Country[country_code]
    c.translations[I18n.locale.to_s] || c.name
  end

  # 国コードを国旗に変更
  def country_flag(country_code)
    return if country_code.blank?

    c = Country[country_code]
    c.emoji_flag
  end
end

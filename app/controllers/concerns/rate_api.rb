module RateApi
  extend ActiveSupport::Concern
  require 'net/http'
  require 'uri'
  require 'json'

  def currency(country)
    Country[country].currency_code
  end

  # def current_country_currency
  #   Country[self.current_country].currency_code
  # end

  def get_base_currency_url(base_currency)
    URI.parse("https://prime.exchangerate-api.com/v5/#{Rails.application.credentials.dig(:RATE_API_KEY)}/latest/#{base_currency}")
  end

  def exchange_rate(base_currency, target_currency)
    uri = get_base_currency_url(base_currency)
    json = Net::HTTP.get(uri)
    rate_json = JSON.parse(json)
    1 / rate_json["conversion_rates"][target_currency]
  end
  
end




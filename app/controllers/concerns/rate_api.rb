module RateApi
  extend ActiveSupport::Concern
  require 'net/http'
  require 'uri'
  require 'json'

  def currency(country)
    return if Country[country].blank?

    Country[country].currency_code
  end

  def rate_hash(base_currency)
    # uri = URI.parse("https://prime.exchangerate-api.com/v5/#{Rails.application.credentials.dig(:RATE_API_KEY)}/latest/#{base_currency}")
    uri = URI.parse("https://api.exchangeratesapi.io/latest?base=#{base_currency}")
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
    # result["conversion_rates"]
    result['rates']
  end

  def rate_json(base_currency)
    JSON.generate(rate_hash(base_currency))
  end

  def exchange_rate(base_currency, target_currency)
    rate_hash(base_currency)[target_currency]
  end

  def all_currencies_array
    rate_hash('USD').keys
  end

  def currency_present?(currency)
    all_currencies_array.map { |c| c == currency }.any?
  end

  def default_currency(country)
    if !currency_present?(currency(country))
      'USD'
    else
      currency(country)
    end
  end
end

module RateApi
  # extend ActiveSupport::Concern
  require 'net/http'
  require 'uri'
  require 'json'

  def exchange(currency)
    uri = URI.parse("https://prime.exchangerate-api.com/v5/#{Rails.application.credentials.dig(:RATE_API_KEY)}/latest/#{currency}")
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
    puts result["conversion_rates"]["JPY"]
  end
  
end




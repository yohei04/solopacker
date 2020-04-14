# module RateApi
#   extend ActiveSupport::Concern
#   require 'net/http'
#   require 'uri'
#   require 'json'

#   def currency(country)
#     Country[country].currency_code
#   end

#   # def current_country_currency
#   #   Country[self.current_country].currency_code
#   # end

#   def rate_hash(base_currency)
#     uri = URI.parse("https://prime.exchangerate-api.com/v5/#{Rails.application.credentials.dig(:RATE_API_KEY)}/latest/#{base_currency}")
#     json = Net::HTTP.get(uri)
#     result = JSON.parse(json)
#     result["conversion_rates"]
#   end

#   def all_currencies_array
#     rate_hash("USD").keys
#   end

#   def exchange_rate(base_currency, target_currency)
#     1 / rate_hash(base_currency)[target_currency]
#   end


  
# end




module StaticPagesHelper

  def searched_recruit_country
    return 'All Recruits' if params[:q].try(:[], :country_cont).blank?

    name = country_name(params[:q][:country_cont])
    name.present? ? "Recruits in #{name}" : 'No such country!'
  end

  require 'net/http'
  require 'uri'
  require 'json'

  def currency(country)
    return if country.blank?
    Country[country].currency_code
  end

  # def current_country_currency
  #   Country[self.current_country].currency_code
  # end

  def rate_hash(base_currency)
    # uri = URI.parse("https://prime.exchangerate-api.com/v5/#{Rails.application.credentials.dig(:RATE_API_KEY)}/latest/#{base_currency}")
    uri = URI.parse("https://api.exchangeratesapi.io/latest?base=#{base_currency}")
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
    # result["conversion_rates"]
    result["rates"]
  end

  def rate_json(base_currency)
    JSON.generate(rate_hash(base_currency))
  end

  def all_currencies_array
    rate_hash("USD").keys
  end

  def currency_present?(currency)
    all_currencies_array.map {|c| c == currency }.any?
  end

  def exchange_rate(base_currency, target_currency)
    base_currency = "USD" unless currency_present?(base_currency)
    target_currency = "USD" unless currency_present?(target_currency)
    rate_hash(base_currency)[target_currency]
  end



end

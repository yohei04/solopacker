module StaticPagesHelper
  def searched_recruit_country
    return 'All Recruits' if params[:q].try(:[], :country_cont).blank?
    name = country_name(params[:q][:country_cont])
    return "No Recruit in #{name} now" if Recruit.find_by(country: params[:q][:country_cont]).blank?
    name.present? ? "Recruits in #{name}" : 'No such country!'
  end

  # ↓Rate関連
  DEFAULT_COUNTRY = 'USD'.freeze

  def currency(country)
    return if Country[country].blank?

    Country[country].currency_code
  end

  def rate_hash(base_currency)
    uri = URI.parse("#{RATE_API_URL}#{base_currency}")
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
    rate_hash(DEFAULT_COUNTRY).keys
  end

  def currency_present?(currency)
    all_currencies_array.map { |c| c == currency }.any?
  end

  def default_currency(country)
    if !currency_present?(currency(country))
      DEFAULT_COUNTRY
    else
      currency(country)
    end
  end
end

module StaticPagesHelper
  def searched_recruit_country
    return 'All Recruits' if params[:q].try(:[], :country_cont).blank?

    name = country_name(params[:q][:country_cont])
    name.present? ? "Recruits in #{name}" : 'No such country!'
  end
end

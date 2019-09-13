class DangerFacade
  attr_reader :start_date, :end_date

  def initialize(date_params)
    @start_date = date_params[:start_date].to_date.to_formatted_s(:long)
    @end_date = date_params[:end_date].to_date.to_formatted_s(:long)
  end
end

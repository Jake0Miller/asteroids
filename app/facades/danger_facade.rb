class DangerFacade
  def initialize(date_params)
    @start_date = date_params[:start_date]
    @end_date = date_params[:end_date]
  end

  def range
    "#{@start_date.to_date.strftime("%B %-d, %Y")} - #{@end_date.to_date.strftime("%B %-d, %Y")}"
  end

  def danger_days
    dangerous_days.transform_values do |asteroids|
      asteroids.find_all {|val| val[:is_potentially_hazardous_asteroid]}
    end.max_by {|a| a[1].length}
  end

  def most_dangerous_day
    danger_days[0].to_s.to_date.strftime("%B %-d, %Y")
  end

  def danger_roids
    danger_days[1].map {|roid| Roid.new(roid[:name], roid[:neo_reference_id])}
  end

  private

  def service
    @_service ||= NasaService.new(@start_date, @end_date)
  end

  def dangerous_days
    @_dangerous_days = service.dangerous_days[:near_earth_objects]
  end
end

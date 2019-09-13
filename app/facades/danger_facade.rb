class DangerFacade
  def initialize(date_params)
    @start_date = date_params[:start_date]
    @end_date = date_params[:end_date]
  end

  def range
    "#{PrettyDate.make_pretty(@start_date)} - #{PrettyDate.make_pretty(@end_date)}"
  end

  def danger_days
    dangerous_days.transform_values do |asteroids|
      asteroids.find_all {|val| val[:is_potentially_hazardous_asteroid]}
    end.max_by {|a| a[1].length}
  end

  def most_dangerous_day
    PrettyDate.make_pretty(danger_days[0].to_s)
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

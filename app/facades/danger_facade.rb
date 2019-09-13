class DangerFacade
  def initialize(date_params)
    @start_date = date_params[:start_date]
    @end_date = date_params[:end_date]
  end

  def range
    start_date = @start_date.to_date.to_formatted_s(:long).split
    start_date[1] = start_date[1].to_i.to_s + ','
    end_date = @end_date.to_date.to_formatted_s(:long).split
    end_date[1] = end_date[1].to_i.to_s + ','

    "#{start_date.join(' ')} - #{end_date.join(' ')}"
  end

  def most_dangerous_day
    dangerous_days.transform_values do |vals|
      vals.count {|val| val[:is_potentially_hazardous_asteroid]}
    end.max_by {|a| a[1]}[0].to_s.to_date.to_formatted_s(:long).split
  end

  def danger_day
    max_day = most_dangerous_day
    max_day[1] = max_day[1].to_i.to_s + ','
    max_day.join(' ')
  end

  private

  def service
    @_service ||= NasaService.new(@start_date, @end_date)
  end

  def dangerous_days
    @_dangerous_days = service.dangerous_days[:near_earth_objects]
  end
end

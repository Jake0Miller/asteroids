class NasaService
  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def dangerous_days
    get_json("neo/rest/v1/feed")
  end

  private

  def conn
    @_conn ||= Faraday.new(url: "https://api.nasa.gov/") do |faraday|
      faraday.params["api_key"] = ENV['api_key']
      faraday.params["start_date"] = @start_date
      faraday.params["end_date"] = @end_date
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end

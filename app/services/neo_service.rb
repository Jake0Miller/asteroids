class NeoService
  def lookup(id)
    get_json("neo/rest/v1/neo/#{id}")
  end

  private

  def conn
    @_conn ||= Faraday.new(url: "https://api.nasa.gov/") do |faraday|
      faraday.params["api_key"] = ENV['api_key']
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end

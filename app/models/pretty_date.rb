class PrettyDate
  def self.make_pretty(ugly_date)
    pretty_date = ugly_date.to_date.to_formatted_s(:long).split
    pretty_date[1] = pretty_date[1].to_i.to_s + ','
    pretty_date.join(' ')
  end
end

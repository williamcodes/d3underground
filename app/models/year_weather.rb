class YearWeather
  include Mongoid::Document

  field :city, type: String
  field :year, type: String
  field :temperatures, type: Hash

end
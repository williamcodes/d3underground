class Condition
  include Mongoid::Document

  field :city, type: String
  field :year, type: String
  field :temperature, type: Hash

end
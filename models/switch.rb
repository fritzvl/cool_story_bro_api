class Switch < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  attribute :index
  attribute :timestamp

end
class Photo < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  attribute :photo_url

end
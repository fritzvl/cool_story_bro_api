class Account < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  # Examples:
  # attribute :name
  # attribute :email, String
  # reference :venue, Venue
  # set :participants, Person
  # counter :votes
  #
  # index :name
  #
  # def validate
  #   assert_present :name
  # end

  attribute :email, String
  attribute :auth_token, String
  attribute :device_id, String
  collection :stories, Story


  def validate
      assert_present :name
      assert_present :device_id
  end
end

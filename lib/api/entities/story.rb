module API
  module Entities
    class Story < Grape::Entity
      expose :id
      expose :album_id
      expose :album_name
      expose :photos_values
      expose :switches_values
    end
  end
end
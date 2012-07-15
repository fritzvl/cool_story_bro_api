class Story < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes
  include Ohm::Callbacks


  attr_accessor :photos_data, :switches_data

  # Examples:
  attribute :album_name
  attribute :album_id
  list :photos, :Photo
  list :switches, :Switch
  reference :account, :Account




  def switches_values
    switches.collect {|entity| [entity.index,entity.timestamp]} unless switches.blank?
  end

  def photos_values
    photos.collect {|entity| entity.photo_url}  unless photos.blank?
  end

  def self.from_json(data)
    Story.create(JSON.parse(data))
  end

  def mp3_url
    "/stories/#{id}.mp3"
  end

  def m4a_url
    "/stories/#{id}.m4a"
  end

  def ogg_url
    "/stories/#{id}.ogg"
  end

  def switches_in_seconds
    unless switches.blank?
      switches_values.collect do |item|
       if item!=switches_values.first
          [item.first, Integer(item[1])-Integer(switches_values.first[1])]
        else
          [item.first, 0]
        end
      end
    else
      []
    end
  end


  protected

  def  after_save
    process_photos_data
    process_switches_data
  end

  def process_photos_data
    unless photos_data.respond_to?(:collect)
      parsed=JSON.parse(photos_data)
      self.photos_data=parsed
    end
    photos.replace(self.photos_data.collect{|entry| Photo.create(:photo_url=>entry)})  unless self.photos_data.blank?
  end

  def process_switches_data
    unless switches_data.respond_to?(:collect)
      parsed=JSON.parse(switches_data)
      switches_data=parsed
    end
    switches.replace(switches_data.collect{|entry| Switch.create(:index=>entry[0],:timestamp=>entry[1])}) unless switches_data.blank?
  end

end

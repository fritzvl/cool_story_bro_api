module Util
  UPLOAD_RAW_PATH=File.expand_path("../../../raw_uploads/", __FILE__)
  UPLOAD_PATH=File.expand_path("../../../public/stories/", __FILE__)
  class AudioProcessor
    def self.queue
      :app
    end

    def self.perform(story_id, file)

      result_path="#{Util::UPLOAD_PATH}/#{story_id}.m4a"
      result_path_mp3="#{Util::UPLOAD_PATH}/#{story_id}.mp3"
      result_path_ogg="#{Util::UPLOAD_PATH}/#{story_id}.ogg"
      puts "Result path created"
      puts result_path

      system "avconv -y -i #{file}  -acodec libvo_aacenc  -ac 2 -ar 32000 -ab 64k " + result_path
      system "avconv -y -i #{file}  -acodec libmp3lame  -ac 2 -ar 32000 -ab 64k " + result_path_mp3
      system "avconv -y -i #{file}  -acodec libvorbis  -ac 2 -ar 32000 -ab 64k " + result_path_ogg

      #puts "Convert finished"
    end
  end
end
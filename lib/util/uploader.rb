module Util

  UPLOAD_RAW_PATH=File.expand_path("../../../raw_uploads/", __FILE__)
  UPLOAD_PATH=File.expand_path("../../public/stories/", __FILE__)



  class Uploader

    def self.process(story, file)
       name=file[:tempfile].path.split("/").last
       FileUtils.mv(file[:tempfile].path,"#{UPLOAD_RAW_PATH}/#{name}")
       puts "#{UPLOAD_RAW_PATH}/#{name}"
       Resque.enqueue(Util::AudioProcessor, story.id, "#{UPLOAD_RAW_PATH}/#{name}")
    end
  end

end
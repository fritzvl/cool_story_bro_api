Dir["../util/*.rb"].each {|file| require file }
module API

  class Stories < Grape::API

    get "/stories.json" do

      present Story.all.entries, with: API::Entities::Story

    end

    get "/stories/:id.json" do
      @story=Story[params[:id]]
      present @story, with: API::Entities::Story
    end

    post "/stories" do

      @story = Story.from_json(params[:data])
      if @story.save
        Util::Uploader.process(@story, params[:file])
      end
    end

    get "/test.json" do
      @story=Story.from_json('{"album_id":"000","photos_data":"[\"https://lh6.googleusercontent.com/-U5I_nndp-V0/Tvb4LQHifrI/AAAAAAAABDk/qlwX8iJJQyc/2011-12-25%25252011.57.30.jpg\"]","album_name":"000","switches_data":"[[-1,1342314718670],[0,1342314727145]]"}')

      present @story, with: API::Entities::Story
    end

  end

end

Ohm::MissingID
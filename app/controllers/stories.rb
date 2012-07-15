#Public part of the web application will be only able to show the created story,
#everything else - using mobile app using the API
Coolstorybro.controllers :stories do


  get :delete_all, :map=>"/delete_all" do
    Story.all.each do |entry|
      entry.delete
    end
  end

  #The only method currently used , and will be used in the near future
  get :show , :map=>"/stories/:id" do
    @story=Story[params[:id]]
    render 'stories/show'
  end

  get :new do
    @story=Story.new
    render 'stories/new'
  end

  post :create do
    puts params.inspect
    @story=Story.from_json(params[:story][:data])
    puts params[:story][:file][:tempfile].path
    if @story.save
      Util::Uploader.process(@story, params[:story][:file])
    end
  end

  put :update do
  end

  delete :destroy do
  end

end

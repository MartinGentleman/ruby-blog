class MediaManagerController < ApplicationController
  
  before_action :require_authorization
  
  def index
    @album_count = Site.current.albums.count
    Site.current.albums.per_page = 10
    @albums = Site.current.albums.page(params[:page]).order('created_at ASC')
  end
  
  # '/media_manager/:album'
  # responds to album id and album title for json, redirect to album title format for html
  # returns paginated album contents on html and full album contents on json
  def album_contents
    respond_to do |format|
      if is_numeric? params[:album] then
        @album = Site.current.albums.find_by_id(params[:album])
        if request.format == "html" then
          format.html { redirect_to media_manager_path(URI.encode(@album.title)) }
        end
      else
        @album = Site.current.albums.find_by_title(URI.decode(params[:album]))
      end
      unless @album then
        return throw_404
      else
        if request.format == "html" then
          @image_count = @album.images.count
          @album.images.per_page = 20
          @images = @album.images.page(params[:page]).order('created_at DESC')
        else
          @images = @album.images.order('created_at DESC')
        end
        format.html
        format.json { render json: @images }
      end
    end
  end
  
  def new
    @album = Album.new
    @album.site_id = Site.current.id
  end
  
  def edit
    @album = Site.current.albums.find(params[:id])
  end
  
  def update
    @album = Site.current.albums.find(params[:id])
 
    if @album.update(title: params["album"]["title"])
      redirect_to media_manager_path(URI.encode(@album.title))
    else
      render 'edit'
    end
  end
  
  def destroy
    @album = Site.current.albums.find(params[:id])
    @album.destroy
 
    redirect_to media_manager_index_path
  end
  
  def create
    respond_to do |format|
      @album = Album.new(title: params["album"]["title"], site_id: Site.current.id)
      if @album.save
        format.html { redirect_to media_manager_path(URI.encode(@album.title)) }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
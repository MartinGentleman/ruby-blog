class ImagesController < ApplicationController
  
  before_action :require_authorization

  def create
    album_id = params["album_id"] ? params["album_id"] : 1
    request.format = :json
    @image = Image.new(image: params[:file], album_id: album_id)
    respond_to do |format|
      if @image.save
        format.json  { render :json => @image, status: :ok }
      else
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    request.format = :json
    respond_to do |format|
      @image = Image.find(params[:id])
      if @image.destroy
        format.json  { render :json => "Image deleted successfully", status: :no_content }
      else
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # /images/all_image_links(/:album_id)
  # takes param [:album_id] and either loads all image links or image links from a specific album
  def all_image_links
    request.format = :json
    respond_to do |format|
      #links get build from file name and id and by default original size is used
      if params[:album_id] then
        images = Album.find(params[:album_id]).images.image_links.order('created_at DESC')
      else
        images = Image.image_links.order('created_at DESC')
      end
      @links = Array.new
      images.each { |a| @links.push(a.link) }
      format.json  { render :json => @links, status: :ok }
    end
  end
  
  private
  def images_params
    params.require(:file).permit(:file)
  end
  
end
class WebPagesController < ApplicationController
  
  before_action :require_authorization, except: [:show, :index]
  
  def index
    @whoami = "web_pages_index"
    web_pages_per_page = 5
    if params[:tag_id] then
      unless is_admin? then
        # published web pages with a specified tag 
        @web_pages = Site.current.web_pages.with_a_tag(params[:tag_id]).published.language(get_locale).ordered.paginate(page: params[:page], per_page: web_pages_per_page)
      else
        # admin can see even unpublished web pages
        @web_pages = Site.current.web_pages.with_a_tag(params[:tag_id]).language(get_locale).ordered_with_nulls.paginate(page: params[:page], per_page: web_pages_per_page)
      end
      @tag_id = params[:tag_id]
    else
      unless is_admin? then
        # published web pages
        @web_pages = Site.current.web_pages.language(get_locale).published.ordered.paginate(page: params[:page], per_page: web_pages_per_page)
      else
        # admin can see even unpublished web pages
        @web_pages = Site.current.web_pages.language(get_locale).ordered.paginate(page: params[:page], per_page: web_pages_per_page)
      end
    end
  end
  
  def admin_index
    @web_page_count = Site.current.web_pages.count
    Site.current.web_pages.per_page = 50
    @web_pages = Site.current.web_pages.page(params[:page]).order('created_at DESC')
  end
  
  def new
    @web_page = WebPage.new
    @web_page.site_id = Site.current.id
    @tag_id = params[:tag_id]
  end
  
  def create
    @web_page = WebPage.new(web_pages_params)
    @web_page.site_id = Site.current.id
    respond_to do |format|
      if @web_page.save
        if params[:web_page][:tag_id] then WebPageTag.create(web_page_id: @web_page.id, tag_id: params[:web_page][:tag_id]) end
        format.html { redirect_to "/"+@web_page.path, notice: 'Page was successfully created.' }
        format.json { render json: @web_page, status: :created, location: @web_page }
      else
        format.html { render action: "new" }
        format.json { render json: @web_page.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @web_page = Site.current.web_pages.find(params[:id])
  end
  
  # POST
  def edit_page_image
    request.format = :json
    respond_to do |format|
      if is_numeric? params[:image_id] then
        @web_page = Site.current.web_pages.find(params[:id])
        @web_page.update(image_id: params[:image_id])
        if @web_page.save
          format.json  { render :json => @web_page, status: :ok }
        else
          format.json { render json: @web_page.errors, status: :unprocessable_entity }
        end
      else
        format.json { render json: ["Bad Request"], status: :bad_request }
      end
    end
  end
  
  def update_content
    request.format = :json
    @web_page = Site.current.web_pages.find(params[:id])
    @web_page.update(title: params[:title], content: params[:body])
    respond_to do |format|
      if @web_page.save
        #format.html { redirect_to @web_page, notice: 'Page was successfully edited.' }
        format.json { render json: @web_page, status: :ok, location: @web_page }
      else
        #format.html { render action: "new" }
        format.json { render json: @web_page.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @web_page = Site.current.web_pages.find(params[:id])
 
    if @web_page.update(web_pages_params)
      redirect_to "/"+@web_page.path
    else
      render 'edit'
    end
  end
  
  def destroy
    @web_page = Site.current.web_pages.find(params[:id])
    @web_page.destroy
 
    redirect_to web_pages_admin_index_path
  end
  
  def show
    @web_page = Site.current.web_pages.find_by_path(URI.encode(params[:path]))

    if @web_page
      respond_to do |format|
        #beware that last modified controls cache for the article as well as the layouts
        #response.headers['Last-Modified'] = @web_page.updated_at.to_s(:rfc822)
        @title = @web_page.title
        #we change locale based on accessed page
        set_locale(@web_page.language)
        if @web_page.image then
          @background_image = @web_page.image.url
        end
        format.html # show the page
        format.json  { render :json => @web_page, status: :ok }
      end
    else
      throw_404
    end
  end
  
  def publish
    @web_page = Site.current.web_pages.find(params[:id])
    @web_page.update(published_at: Time.now)
    if @web_page.save
      redirect_to "/"+@web_page.path
    else
      redirect_to "/"+@web_page.path
    end
  end
  
  private
  def web_pages_params
    params.require(:web_page).permit(:title, :path, :summary, :language)
  end
end

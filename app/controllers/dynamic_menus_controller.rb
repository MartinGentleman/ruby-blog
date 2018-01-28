class DynamicMenusController < ApplicationController
  
  before_action :require_authorization
  
  def edit
    @title = params[:id]
    @dynamic_menu = DynamicMenu.find_all_web_pages_by_dynamic_menu_title(@title)
    @available_pages = Site.current.web_pages.language(get_locale).published.ordered
  end
  
  # POST
  def replace_by_menu_title
    request.format = :json
    @title = params[:menu_name]
    @dynamic_menu_contents = params[:dynamic_menu]
    respond_to do |format|
      if DynamicMenu.replace(@title, @dynamic_menu_contents)
        format.json { render json: @dynamic_menu_contents, status: :ok }
      else
        format.json { render json: "Transaction failed.", status: :unprocessable_entity }
      end
    end
  end
  
end

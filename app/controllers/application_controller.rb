class ApplicationController < ActionController::Base
  before_action :set_locale, :set_current_site

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :is_admin?, :is_numeric?, :get_website_address, :get_locale, :get_host
  
  theme :theme_resolver
  
  def set_current_site
    Site.set_current(request.host_with_port)
  end
  
  def theme_resolver
    return Site.current.id
  end
 
  def set_locale(locale = nil)
    if !locale.nil? then
      session[:locale] = locale
      I18n.locale = session[:locale] || I18n.default_locale
      return
    end
    if params[:locale] && session[:locale] && params[:locale] != session[:locale] then
      session[:locale] = params[:locale];
      if params[:locale] == 'en' then
        redirect_to '/'
      end
    elsif !session[:locale] then
      #session[:locale] = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      session[:locale] = 'en'
      #be always english by default
    end
    I18n.locale = session[:locale] || I18n.default_locale
    if request.env['PATH_INFO'].eql?('/')  && session[:locale] != 'en' then
      redirect_to '/'+session[:locale]
    end
  end
  
  def get_locale
    return session[:locale]
  end
  
  def require_authorization
    unless is_admin?
      #flash[:error] = "You must be logged in to access this section"
      #redirect_to rule_me_url, :alert => "You are not authorized" # halts request cycle
      #I am showing 404 as not to give away that there is some administration part on a specific URL
      throw_404
    end
  end
  
  def is_admin?
    if session[:user_id] then return true
    else return false
    end
  end
  
  def is_numeric?(obj)
    if obj.blank? || obj.to_s != obj.to_i.to_s
      return false
    else
      return true
    end
  end
  
  def get_website_address
    return request.base_url
  end
  
  def throw_404
    respond_to do |format|
      format.html {
        @web_page = WebPage.new
        @web_page.title = t(:Page_Not_Found)
        @web_page.content = '<p>'+t(:The_page_was_not_found)+'</p>'
        
        render :template  => "/web_pages/show", :status => 404
      }
      format.json { render json: ["Page Not Found"], status: :not_found }
    end
  end
end

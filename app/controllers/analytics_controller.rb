class AnalyticsController < ApplicationController
  
  before_action :require_authorization
  
  class_attribute :setting_key
  self.setting_key = "analytics.tracking_id"
  
  def index
    # console https://developers.google.com/api-client-library/javascript/start/start-js#Setup
    # console https://console.developers.google.com/project/495677376569/apiui/credential
    # embed api https://developers.google.com/analytics/devguides/reporting/embed/v1/devguide
    @analytic = Site.current.settings.key(self.setting_key)
    if @analytic.blank? then
      redirect_to analytics_settings_path
    end
  end
  
  def settings
    @analytic = Site.current.settings.key(self.setting_key)
    if @analytic.blank? then
      @analytic = Setting.new
      @analytic.key = self.setting_key
      @analytic.site_id = Site.current.id
    end
  end
  
  def update_settings
    @analytic = Site.current.settings.key(self.setting_key)
    if @analytic.blank? then
      @analytic = Setting.new
      @analytic.site_id = Site.current.id
      @analytic.key = self.setting_key
    end
    @analytic.value = params[:setting][:value]
    if @analytic.save then
      redirect_to :analytics
    else
      render "settings"
    end
  end
  
 end
class SessionsController < ApplicationController
  
  before_action :require_authorization, only: [:destroy]
  
  def new
  end

  def create
    if user = User.authenticate(params[:name], params[:password])
      session[:user_id] = 1
      redirect_to root_url
    else
      redirect_to rule_me_url, :alert => t(:Invalid_credentials)
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end

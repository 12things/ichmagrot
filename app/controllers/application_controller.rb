class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  
  def current_or_new_user
    current_user ? current_user : User.create
  end
  
  def authenticate key
    user = User.find_by_key(key)
    if user
      store_in_session user
    end
    current_user
  end
  
  def store_in_session user
    session[:current_user] = user.id
  end
    
  def check_authenticated
    signed_in? ? true : redirect_to(root_path)
  end
end

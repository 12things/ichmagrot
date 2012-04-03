module ApplicationHelper

  def signed_in?
    !session[:current_user].nil?
  end
  
  def current_user
    signed_in? ? User.find(session[:current_user]) : nil
  end
end

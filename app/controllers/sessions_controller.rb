# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  
  def logout
    session[:current_user] = nil
    redirect_to root_path
  end
  
  def login
    session[:current_user] = nil
    user = authenticate(params[:key])
    redirect_to book_path(params[:book_id])
  end
end

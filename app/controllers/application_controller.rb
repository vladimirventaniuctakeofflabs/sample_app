class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  include SessionsHelper

  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    rescue_from CanCan::AccessDenied do | exception |
      
      if logged_in?
        store_location
        flash[:danger] = "Access denied."
        redirect_to root_url
      else
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
end

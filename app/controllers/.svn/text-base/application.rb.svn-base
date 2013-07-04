# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base

  private
  
  # This method generally filters all requests (at this point only for 
  # the user controler except login, register, register_form and index actions) for authorization.
  # Additionally the requested URL that is forbidden is kept in session in order to 
  # redirect when login succeeds.
  def authorize
    unless session[:user_id] && session[:is_admin]
      if request.request_uri != "main/login" && request.request_uri != "main/register_form"
        session[:original_url] = request.request_uri
      end
      flash[:notice] = "Трябва да сте администратор, за да можете да достъпите това съдържание."
      redirect_to(:controller => "main" , :action => "index" )
    end
  end

end
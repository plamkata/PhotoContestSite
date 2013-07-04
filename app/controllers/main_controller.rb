class MainController < ApplicationController

  # Trys to outhenticate the user and if authentication succedes logs him/her in the system.
  def login
    session[:user_id] = nil
    session[:is_admin] = nil
    if request.post?
      user = User.authenticate(params[:loginame], params[:pass])
      if user
        @user = user
        log_user @user
      else
        flash[:notice] = "Невалидна комбинация от потребителско име и парола."
        redirect_to :action => "index"
      end
    end
  end

  # Log the user out redirecting to index.
  def logout
    session[:user_id] = nil
    session[:is_admin] = nil
    flash[:notice] = "Успешно излязохте от системата."
    redirect_to :action => "index" 
  end
  
  # Creates new user and logs him/her if creation was successful.
  def register_form
    @user = User.new
    @form_title = "Регистрация на потребител"
    @button_value = "Регистрация"
  end
  
  def register
    @user = User.new(params[:user])
    @user.register_date = Time.now
    if @user.save
      flash[:notice] = "Потребител '#{@user.loginame}' беше успешно създаден!"
      #@user = User.new
      #@user.register_date = Time.now
      log_user @user
    else
      @form_title = "Регистрация на потребител"
      @button_value = "Регистрация"
      render :action => 'register_form'
    end
  end
  
  # Loads the current user from database and displays his 
  # old properties to be edited by the user.
  def edit_user_form
    begin
      @user = User.find(session[:user_id])
    rescue
      redirect_to :action => :index
    end
    @form_title = "Промяна на потребител"
    @button_value = "Промяна"
  end
  
  # Loads the current user from database and tries to perform an update
  # from the form - if successful redirects to index, if not errors are 
  # displayed in the form.
  def edit_user
    begin
      @user = User.find(session[:user_id])
      
      if (@user && @user.update_attributes(params[:user]))
        flash[:notice] = "Потребителя ви бе успешно променен."
        redirect_to :action => :index
        return       
      end 
    rescue
      # ignore
    end
    
    @form_title = "Промяна на потребител"
    @button_value = "Промяна"
    render :action => 'edit_user_form'
  end

  private 
  
  # Sets session's user_id and redirects to originally requested page or
  # alternatively to index
  def log_user (user)
    session[:user_id] = user.id
    session[:is_admin] = user.is_admin == 1
    # redirect_to(session[:original_url] || { :action => "index" } )
    redirect_to :action => "index" 
  end
  
end

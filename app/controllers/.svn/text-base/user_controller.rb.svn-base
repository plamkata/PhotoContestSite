class UserController < PaginationController
  before_filter :authorize, :only => [:delete_user, :change_is_admin]
  
  #  layout "general"
  
  # Lists all users in order to show them. 
  # This is the way paggination works. 
  def list_users
    # Call get_orders in order to initalize the @orderer and use it later
    # in paging tags or sorting tags
    orders = get_orders
    if orders.nil?
      # default orders
      orders = "register_date desc"
    end
    
    paginate_model(User, {:per_page => 10, :order => orders})
  end
  
  # deletes a user from the database; if the current user
  # deletes him/her self than he will be redirected to login page
  # since authentication should fail
  def delete_user
    user = User.find(params[:target_id])
    if user
      user.destroy
      render :nothing => true
    end
  end
  
  # Toggles the is_admin property of the user selected.
  def change_is_admin
    user = User.find(params[:target_id])
    if user
      if user.is_admin == 1
        user.is_admin = 0
      elsif user.is_admin == 0
        user.is_admin = 1
      end
      if user.update
        render :partial => 'user', :object => user
      end
    end
  end
  
end

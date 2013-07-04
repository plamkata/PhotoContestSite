class PictureController < PaginationController
#TODO: before filter

  # Lists all pictures in order to show them. 
  # This is the way paggination works. 
  def list_pictures
    @contest = Contest.find(params[:contest_id])
    
    # Call get_orders in order to initalize the @orderer and use it later
    # in paging tags or sorting tags
    orders = get_orders
    if orders.nil?
      # default orders
      orders = "name"
    end
    
    paginate_model(Picture, {
      :per_page => 8, 
      :order => orders, 
      :conditions => ["contest_id = ?", params[:contest_id]]
    })
  end
  
  # Prepares the new picture form for rendering, creating a new picture object
  # and setting default values.
  def new_picture_form
    @contest = Contest.find(params[:contest_id])
    
    @picture = Picture.new
    prepare_picture @picture, "Добавяне на снимка", "Добави"
  end
  
  # Creates a new picture with the data to be filled in and saves it to database.
  # When successfull the form is redirected to list_pictures and when not it
  # is again rendered to show the validation messages.
  def new_picture
    @contest = Contest.find(params[:picture][:contest_id])
    begin
      @picture = Picture.new(params[:picture])
      @picture.format = File.extname(@picture.name)
    
      if @picture.save
        # reload the atributes in order to render them
        @picture = Picture.find(@picture.id)
        
        responds_to_parent do
          render :update do |page|
            page.replace_html 'picture_form', :partial => 'picture', :object => @picture
          end
        end
      else
        prepare_picture @picture, "Добавяне на снимка", "Добави"
        responds_to_parent do
          render :update do |page|
            page.replace_html 'picture_form', :partial => 'picture_form', :object => @picture
          end
        end
      end
    rescue Exception => e
      puts e
      flash[:notice] = "Unsuccessfull: " + e
    end
  end
  
  def picture_cancel
    begin
      # reload the old contest data if such exists
      picture = Picture.find(params[:target_id])
      
      if (contest)
        render :partial => "picture", :object => picture
      else 
        # new_contest_form was canceled
        render :nothing => true
      end 
    rescue
      # ignore
      render :nothing => true
    end
  end
  
  def rate_picture
    @user_rating = UserRating.find(:first, :conditions => ["user_id = ? and picture_id = ?", session[:user_id], params[:picture_id]])
    if @user_rating
      @user_rating.rating = params[:rate]
      if @user_rating.update
        render :partial => 'rating', :object => @user_rating
      end
    else
      @user_rating = UserRating.new
      @user_rating.user_id = session[:user_id]
      @user_rating.picture_id = params[:picture_id]
      @user_rating.rating = params[:rate]
      if @user_rating.save
        render :partial => 'rating', :object => @user_rating
      end
    end
  end
  
  # Simply destroys the selected contest to be deleted and according to the 
  # on delete cascade foreign keys in the database all associated pictures 
  # and their associated ratings will be also deleted. Admins shall rather
  # use change_is_visible than directly deleting. However when deletion is 
  # successful the contest simply disappears from the list.
  def delete_picture
    picture = Picture.find(params[:target_id])
    if picture
      picture.destroy
      render :nothing => true
    end
  end
  
  private 
  
  # Prepares the instance variables that configure the 
  # look of the contest_form partial for rendering.
  def prepare_picture(picture, title, btn_value)
    @form_title = title
    @button_value = btn_value
  end
  
end

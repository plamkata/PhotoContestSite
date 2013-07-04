class ContestController < PaginationController

  before_filter :authorize, :except => [:list_contests, :blank]
  
  # Lists all contests in order to show them. 
  # This is the way paggination works. 
  def list_contests
    # default conditions
    conditions = ["is_visible = 1"]
    
    # Call get_orders in order to initalize the @orderer and use it later
    # in paging tags or sorting tags
    orders = get_orders
    if orders.nil?
      # default orders
      orders = "start_date desc, end_date"
    end
    
    if session[:is_admin]
      conditions = nil
      orders = "is_visible desc, " + orders
    end
    paginate_model(Contest, {:per_page => 3, :conditions => conditions, :order => orders})
  end
  
  # Prepares the new contest form for rendering, creating a new contest object
  # and setting default values.
  def new_contest_form
    @contest = Contest.new
    @contest.is_visible = 1
    prepare_contest @contest, "Нов конкурс", "Създай"
  end
  
  # Creates a new contest with the data to be filled in and saves it to database.
  # When successfull the form is redirected to 'list_contests' and when not it
  # is again rendered to show the validation messages.
  def new_contest
    @contest = Contest.new(params[:contest])
    if @contest.save
      # reload the atributes in order to render them - crashes oddly when you don't do it
      # the dates cannot be formated properly and undefined method exc occures
      @contest = Contest.find(@contest.id)
      return render(:partial => "contest", :object => @contest)
    else
      @contest.create_dates
      prepare_contest @contest, "Нов конкурс", "Създай"
      render :action => 'new_contest_form'
    end
  end
  
  # Loads the current user from database and displays his 
  # old properties to be edited by the user.
  def edit_contest_form
    begin
      @contest = Contest.find(params[:target_id])
    rescue
      redirect_to :action => 'list_contests'
    end
    prepare_contest @contest, "Промяна на конкурс", "Промяна"
  end
  
  # Loads the current user from database and tries to perform an update
  # from the form - if successful redirects to index, if not errors are 
  # displayed in the form.
  def edit_contest
    begin
      @contest = Contest.find(params[:target_id])
      
      if (@contest && @contest.update_attributes(params[:contest]))
        flash[:notice] = "Конкурса '#{ @contest.title }' бе успешно променен."
        # reload the atributes in order to render them - crashes oddly when you don't do it
        # the dates cannot be formated properly and undefined method exc occures
        @contest = Contest.find(@contest.id)
        return render(:partial => "contest", :object => @contest)
      end 
    rescue
      puts "\n " + "exception cought"
    end
    prepare_contest @contest, "Промяна на конкурс", "Промяна"
    return render(:action => 'edit_contest_form')
  end
  
  def contest_cancel
    begin
      # reload the old contest data if such exists
      contest = Contest.find(params[:target_id])
      
      if (contest)
        render :partial => "contest", :object => contest
      else 
        # new_contest_form was canceled
        render :nothing => true
      end 
    rescue
      # ignore
      render :nothing => true
    end
  end
  
  # Toggles the is_visible property of a contest.
  def change_is_visible
    contest = Contest.find(params[:target_id])
    if contest
      if contest.is_visible == 1
        contest.is_visible = 0
      elsif contest.is_visible == 0
        contest.is_visible = 1
      end
      if contest.update
        render :partial => 'contest', :object => contest
      end
    end
  end
  
  # Simply destroys the selected contest to be deleted and according to the 
  # on delete cascade foreign keys in the database all associated pictures 
  # and their associated ratings will be also deleted. Admins shall rather
  # use change_is_visible than directly deleting. However when deletion is 
  # successful the contest simply disappears from the list.
  def delete_contest
    contest = Contest.find(params[:target_id])
    if contest
      contest.destroy
      render :nothing => true
    end
  end
  
  private 
  
  # Prepares the instance variables that configure the 
  # look of the contest_form partial for rendering.
  def prepare_contest(contest, title, btn_value)
    @start_date_default = (contest.nil? || contest.start_date.nil?) ? Time.now : contest.start_date
    @end_date_default = (contest.nil? || contest.end_date.nil?) ? Time.now : contest.end_date
    @form_title = title
    @button_value = btn_value
  end
  
end

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def show_content(user_list_url, contest_list_url, picture_list_url)
    actions = ""
    actions += remote_function :update => "user_list",
      :url => {:controller => 'user'}.update(user_list_url), 
      :method => :get
    actions += "; "  
    actions += remote_function :update => "contest_list",
      :url => {:controller => 'contest'}.update(contest_list_url), 
      :method => :get
    actions += "; "
    actions += remote_function :update => "picture_list",
      :url => {:controller => 'picture'}.update(picture_list_url), 
      :method => :get
    actions += "; return false; "      
    return actions
  end
  
  def list_contests_menu_names(controller)
    @contests = Contest.find(:all, :conditions => ["is_visible = 1"], :order => "start_date desc, end_date", :limit => 10 )
    return controller.render(:partial => 'contests_menu_names', :object => @contests)
  end
  
  # The first two parameters are paginator (where the current page is kept) and 
  # orderer (optional hash - where the last (order_by, asc) pair is kept).
  # 
  # This is the pagination tag used to display page numbers.
  def ajax_pagination_links(paginator, orderer, options={})
    
    options.merge!(ActionView::Helpers::PaginationHelper::DEFAULT_OPTIONS) {|key, old, new| old}
    options[:params].delete(options[:name])
    options[:params].delete('order_by')
    options[:params].delete('asc')
    
    window_pages = paginator.current.window(options[:window_size]).pages
    
    return if window_pages.length <= 1 unless
    options[:link_to_current_page]
    
    first, last = paginator.first, paginator.last
    
    if orderer.nil?
      orderer = {}
    end
    sorting_column = nil;
    asc = nil;
    orderer.each do |column, direction|
      sorting_column = column
      asc = direction
    end
    
    returning html = '' do
      if options[:always_show_anchors] and not window_pages[0].first?
        html << link_to_remote(first.number, :update => options[:update], :url => { 
            options[:name] => first, 'order_by' => sorting_column, 'asc' => asc
        }.update(options[:params]))
        html << ' ... ' if window_pages[0].number - first.number > 1
        html << ' '
      end
      
      window_pages.each do |page|
        if paginator.current == page && !options[:link_to_current_page]
          html << page.number.to_s
        else
          html << link_to_remote(page.number, :update => options[:update], :url => { 
              options[:name] => page, 'order_by' => sorting_column, 'asc' => asc
          }.update(options[:params]))
        end
        html << ' '
      end
      
      if options[:always_show_anchors] && !window_pages.last.last?
        html << ' ... ' if last.number - window_pages[-1].number > 1
        html << link_to_remote(paginator.last.number, :update => options[:update], :url => { 
            options[:name] => last, 'order_by' => sorting_column, 'asc' => asc
        }.update( options[:params]))
      end
    end
  end 
  
  # The first two parameters are paginator (where the current page is kept) and 
  # orderer (optional hash - where the last (order_by, asc) pair is kept).
  # 
  # Also a hash options[:columns] of {:sorting_column => 'visual_name'} should be provided to
  # visualize the component.
  # 
  # Two parameters are needed in the url - one for the sorting column (params[:order_by]) and 
  # one for the direction (params[:asc]). The page parameter will be again options[:name].
  def ajax_sorting_links(paginator, orderer, options={})
    
    options.merge!(ActionView::Helpers::PaginationHelper::DEFAULT_OPTIONS) {|key, old, new| old}
    options[:params].delete(options[:name])
    options[:params].delete('order_by')
    options[:params].delete('asc')
    
    columns = options[:columns]
    if columns.nil? 
      columns = {}
    end
    
    if orderer.nil?
      orderer = {}
    end
    
    returning html = 'Подреди по: ' do
      
      columns.each do |sorting_column, visual_name|
        asc = !orderer[sorting_column]
        html << link_to_remote(visual_name + " #{asc ? '[asc]' : '[desc]'}", :update => options[:update], 
            :url => { options[:name] => paginator.current, 'order_by' => sorting_column, 'asc' => asc
                    }.update(options[:params]))
        html << ' '
      end
      
    end
  end 
  
end

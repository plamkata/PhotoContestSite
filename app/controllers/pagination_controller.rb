class PaginationController < ApplicationController
  
  # Creates two instance variables: first {model}_pages for the paginator 
  # and second {model}s for the collection on the current page. 
  # 
  # Parameter model is the name of the object to be paginated.
  # Parameter options include
  #   :per_page     number of listed objects per page
  #   :conditions   optional, conditions passed as [ "user_name = ? and id > ?", username, 5 ]
  #   :order        optional, order parameter passed as "is_admin DESC, user_name"
  #
  def paginate_model(model, options)
    paginator_name = "@#{model.name.underscore}_pages".to_sym
    plural_model_name = "@#{model.name.underscore.pluralize}".to_sym
    
    paginator = Paginator.new(self, count_collection_for_pagination(model, options), options[:per_page], @params['page'])
    self.instance_variable_set(paginator_name, paginator)
    
    plural_model = find_collection_for_pagination(model, options, paginator)
    self.instance_variable_set(plural_model_name, plural_model)
  end
  
  # Provides the order by clause to be used with orderer and 
  # initalizes @orderer for order usage. 
  def get_orders
    if params['order_by'].nil?
      return nil
    else
      @orderer = {params['order_by'] => params['asc']}
      orders = params['order_by']
      if !params['asc']
        orders = orders + " desc"
      end
      return orders
    end
  end
  
  def blank
  end
  
end

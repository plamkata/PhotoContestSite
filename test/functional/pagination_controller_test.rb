require File.dirname(__FILE__) + '/../test_helper'
require 'pagination_controller'

# Re-raise errors caught by the controller.
class PaginationController; def rescue_action(e) raise e end; end

class PaginationControllerTest < Test::Unit::TestCase
  def setup
    @controller = PaginationController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end

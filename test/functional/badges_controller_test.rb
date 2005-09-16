require File.dirname(__FILE__) + '/../test_helper'
require 'badges_controller'

# Re-raise errors caught by the controller.
class BadgesController; def rescue_action(e) raise e end; end

class BadgesControllerTest < Test::Unit::TestCase
  def setup
    @controller = BadgesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end

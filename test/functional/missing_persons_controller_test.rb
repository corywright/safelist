require File.dirname(__FILE__) + '/../test_helper'
require 'missing_persons_controller'

# Re-raise errors caught by the controller.
class MissingPersonsController; def rescue_action(e) raise e end; end

class MissingPersonsControllerTest < Test::Unit::TestCase
  def setup
    @controller = MissingPersonsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end

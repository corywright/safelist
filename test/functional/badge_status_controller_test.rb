require File.dirname(__FILE__) + '/../test_helper'
require 'badge_status_controller'

# Re-raise errors caught by the controller.
class BadgeStatusController; def rescue_action(e) raise e end; end

class BadgeStatusControllerTest < Test::Unit::TestCase
  fixtures :badge_status

  def setup
    @controller = BadgeStatusController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:badge_status)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:badge_status)
    assert assigns(:badge_status).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:badge_status)
  end

  def test_create
    num_badge_status = BadgeStatus.count

    post :create, :badge_status => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_badge_status + 1, BadgeStatus.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:badge_status)
    assert assigns(:badge_status).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil BadgeStatus.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      BadgeStatus.find(1)
    }
  end
end

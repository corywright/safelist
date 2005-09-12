require File.dirname(__FILE__) + '/../test_helper'
require 'organization_members_controller'

# Re-raise errors caught by the controller.
class OrganizationMembersController; def rescue_action(e) raise e end; end

class OrganizationMembersControllerTest < Test::Unit::TestCase
  fixtures :organization_members

  def setup
    @controller = OrganizationMembersController.new
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

    assert_not_nil assigns(:organization_members)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:organization_members)
    assert assigns(:organization_members).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:organization_members)
  end

  def test_create
    num_organization_members = OrganizationMembers.count

    post :create, :organization_members => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_organization_members + 1, OrganizationMembers.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:organization_members)
    assert assigns(:organization_members).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil OrganizationMembers.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      OrganizationMembers.find(1)
    }
  end
end

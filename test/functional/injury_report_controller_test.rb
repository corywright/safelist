require File.dirname(__FILE__) + '/../test_helper'
require 'injury_report_controller'

# Re-raise errors caught by the controller.
class InjuryReportController; def rescue_action(e) raise e end; end

class InjuryReportControllerTest < Test::Unit::TestCase
  fixtures :injury_reports

  def setup
    @controller = InjuryReportController.new
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

    assert_not_nil assigns(:injury_reports)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:injury_report)
    assert assigns(:injury_report).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:injury_report)
  end

  def test_create
    num_injury_reports = InjuryReport.count

    post :create, :injury_report => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_injury_reports + 1, InjuryReport.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:injury_report)
    assert assigns(:injury_report).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil InjuryReport.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      InjuryReport.find(1)
    }
  end
end

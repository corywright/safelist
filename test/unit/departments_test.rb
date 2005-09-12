require File.dirname(__FILE__) + '/../test_helper'

class DepartmentsTest < Test::Unit::TestCase
  fixtures :departments

  def setup
    @departments = Departments.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Departments,  @departments
  end
end

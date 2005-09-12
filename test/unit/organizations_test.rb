require File.dirname(__FILE__) + '/../test_helper'

class OrganizationsTest < Test::Unit::TestCase
  fixtures :organizations

  def setup
    @organizations = Organizations.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Organizations,  @organizations
  end
end

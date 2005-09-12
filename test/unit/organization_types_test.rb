require File.dirname(__FILE__) + '/../test_helper'

class OrganizationTypesTest < Test::Unit::TestCase
  fixtures :organization_types

  def setup
    @organization_types = OrganizationTypes.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of OrganizationTypes,  @organization_types
  end
end

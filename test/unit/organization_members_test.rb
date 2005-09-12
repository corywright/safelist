require File.dirname(__FILE__) + '/../test_helper'

class OrganizationMembersTest < Test::Unit::TestCase
  fixtures :organization_members

  def setup
    @organization_members = OrganizationMembers.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of OrganizationMembers,  @organization_members
  end
end

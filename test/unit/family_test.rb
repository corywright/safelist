require File.dirname(__FILE__) + '/../test_helper'

class FamilyTest < Test::Unit::TestCase
  fixtures :families

  def setup
    @family = Family.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Family,  @family
  end
end

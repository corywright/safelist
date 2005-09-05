require File.dirname(__FILE__) + '/../test_helper'

class PersonTypeTest < Test::Unit::TestCase
  fixtures :person_types

  def setup
    @person_type = PersonType.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of PersonType,  @person_type
  end
end

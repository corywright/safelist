require File.dirname(__FILE__) + '/../test_helper'

class EthnicityTest < Test::Unit::TestCase
  fixtures :ethnicities

  def setup
    @ethnicity = Ethnicity.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Ethnicity,  @ethnicity
  end
end

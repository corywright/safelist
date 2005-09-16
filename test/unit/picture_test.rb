require File.dirname(__FILE__) + '/../test_helper'

class PictureTest < Test::Unit::TestCase
  fixtures :pictures

  def setup
    @picture = Picture.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Picture,  @picture
  end
end

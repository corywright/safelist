require File.dirname(__FILE__) + '/../test_helper'

class BadgeStatusTest < Test::Unit::TestCase
  fixtures :badge_status

  def setup
    @badge_status = BadgeStatus.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of BadgeStatus,  @badge_status
  end
end

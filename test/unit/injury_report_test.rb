require File.dirname(__FILE__) + '/../test_helper'

class InjuryReportTest < Test::Unit::TestCase
  fixtures :injury_reports

  def setup
    @injury_report = InjuryReport.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of InjuryReport,  @injury_report
  end
end

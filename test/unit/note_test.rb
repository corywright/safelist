require File.dirname(__FILE__) + '/../test_helper'

class NoteTest < Test::Unit::TestCase
  fixtures :notes

  def setup
    @note = Note.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Note,  @note
  end
end

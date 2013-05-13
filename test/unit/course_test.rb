require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  def test_titulo_no_puede_estar_vacio
    course = courses(:one)
    course.name = nil
    assert !course.save, "sin titulo no deberia salvar"
    assert !course.valid?
    assert_not_nil course.errors[:name]

  end
end

require 'test_helper'

class CourseTest < ActiveSupport::TestCase

  def test_titulo_no_puede_estar_vacio
    course = courses(:one)
    course.name = nil
    assert !course.save, "sin titulo no deberia salvar"
    assert !course.valid?
    assert_not_nil course.errors[:name]

  end

  test "a course with title" do
    valid_course = courses(:valid)

    assert valid_course.valid?

    assert_equal 0, valid_course.errors.size


  end

end

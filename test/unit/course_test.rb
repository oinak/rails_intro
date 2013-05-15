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
    assert valid_course.valid?, "un curso con nombre debe ser valido #{valid_course.errors.inspect}"
    assert_equal 0, valid_course.errors.size, "un curso con nombre no debe tener errores"
  end

  test "an active course" do
    @course = courses(:active)
    assert @course.valid?, "is not valid"
    @course.start_date = 1.day.ago

    assert_equal false, @course.save, "is not valid in the past"
    assert_raise(ActiveRecord::RecordInvalid, "raises RecordInvalid"){
      @course.save!
    }
  end

  test "a past course" do
    past_course = courses(:past)
    assert past_course.valid?, "is not valid #{past_course.errors.inspect}"
    past_course.active = true

    assert_equal false, past_course.save, "is not valid if activated"
    assert_raise(ActiveRecord::RecordInvalid, "raises RecordInvalid"){
      past_course.save!
    }
  end


end

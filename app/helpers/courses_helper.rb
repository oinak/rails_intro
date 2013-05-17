module CoursesHelper

  def link_to_editions(course)
    ed_count = course.editions.size
    if ed_count == 0
      link_to("Add",new_course_edition_path(course))
    else
      link_to("View #{ed_count}", course_editions_path(course))
    end
  end

end

class RegistrationsController < ApplicationController
  before_action :set_course
  before_action :set_user
  before_action :authenticate_user
  before_action :check_user_is_user_and_student_registrations, only: [:add_course, :drop_course]
  skip_before_action :verify_authenticity_token

  def add_course
    # TODO: Drop course and redirect to @user
    # Reminder: be sure to check if 
    # 1) @user is a student
    # 2) @user is NOT registered to the @course
    if (User.students.include?(@user)) && (not @course.users.include?(@user))
      @course.users << @user
      redirect_to @user
    end
  end

  def drop_course
    # TODO: Drop course and redirect to @user
    # Reminder: be sure to check if 
    # 1) @user is a student
    # 2) @user is registered to the @course
    if (User.students.include?(@user)) && (@course.users.include?(@user))
      @course.users.delete(@user)
      redirect_to @user
    end
  end

  private
  
  def set_course
    # TODO: find the course using `course_id`
    @course = Course.find(params[:course_id])
  end

  def set_user
    # TODO: find the user using `course_id` typo? user_id?
    @user = User.find(params[:user_id])
  end

  def check_user_is_user_and_student_registrations
    if (not @user == current_user) || (current_user.is_instructor)
      redirect_to '/courses'
    end
  end

end
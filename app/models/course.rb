class Course < ApplicationRecord
  belongs_to :department

  has_many :registrations, dependent: :destroy
  has_many :users, through: :registrations

  validates :department, presence: true
  validates :code, presence: true, uniqueness: {scope: :department}
  validates :title, presence: true
  validates :description, presence: true

  def full_code
    combined_name = "#{department.code}-#{code}"
  end

  def instructor
    instructor_user = users.find_by(is_instructor: true)
    instructor_user
  end

  def instructor=(user)
    if user.is_instructor
      users << user
    end
  end

  def students
    student_array = users.where(is_instructor: false)
    student_array
  end
end
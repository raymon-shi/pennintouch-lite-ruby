require 'bcrypt'
class User < ApplicationRecord
  has_many :registrations, dependent: :destroy
  has_many :courses, through: :registrations
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :pennkey, presence: true
  validates :password_hash, presence: true

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def full_name
    full_name = "#{first_name}" + " " + "#{last_name}"
    full_name
  end

  def self.students
    student_users = User.where(is_instructor: false)
    student_users
  end

  def self.instructors
    instructor_users = User.where(is_instructor: true)
    instructor_users
  end
end

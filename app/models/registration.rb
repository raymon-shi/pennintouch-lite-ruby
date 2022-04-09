class Registration < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :user, uniqueness: {scope: :course}
  validates :course, uniqueness: {scope: :user}
end

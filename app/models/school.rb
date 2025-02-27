class School < ApplicationRecord
  validates :name, presence: true

  has_many :klasses
  has_many :students
end

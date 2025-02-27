class Klass < ApplicationRecord
  validates :number, :letter, presence: true

  belongs_to :school
  has_many :students
end

class Klass < ApplicationRecord
  belongs_to :school

  validates :number, :letter, presence: true
end

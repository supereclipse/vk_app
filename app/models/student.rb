class Student < ApplicationRecord
  validates :first_name, :last_name, :surname, presence: true

  belongs_to :klass
  belongs_to :school
end

class Car < ApplicationRecord
  belongs_to :driver, inverse_of: :car
  has_many :riders, inverse_of: :car

  def has_space?
    riders.size < driver.total_space 
  end
end

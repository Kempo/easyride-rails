# add riders_count to car table and delegate it to driver?
class Car < ApplicationRecord
  belongs_to :driver, inverse_of: :car, counter_cache: :riders_count
  has_many :riders, inverse_of: :car

  def has_space
    riders.size < driver.total_space 
  end
end

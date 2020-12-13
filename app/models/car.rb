class Car < ApplicationRecord
  belongs_to :driver, inverse_of: :car, counter_cache: true
  has_many :riders, dependent: :destroy

end

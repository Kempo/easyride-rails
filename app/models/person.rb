# fields: name, address
class Person < ApplicationRecord
  self.abstract_class = true                 

  validates :name, presence: true
  validates :address, presence: true

end

class Car < ApplicationRecord
  belongs_to :driver, inverse_of: :car
  has_many :riders, inverse_of: :car

  validates :driver, presence: true
  validates :riders, length: { maximum: :total_space }

  def has_space?
    riders.size < :total_space 
  end

  def clear_space
    riders.delete_all
  end
end

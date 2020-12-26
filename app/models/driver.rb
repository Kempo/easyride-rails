class Driver < Person
  has_one :car, inverse_of: :driver, dependent: :destroy
  delegate :riders, to: :car

  has_many :associations, class_name: 'Preference', as: :preferrer, dependent: :destroy
  has_many :preferences, through: :associations, source: :preferable, source_type: 'Rider'

  after_create :create_car!

  def add_passenger(rider:)
    riders << rider if car.has_space
  end

  def remove_passenger(rider:) 
    riders.delete(rider) if riders.exists?(rider.id)
  end
end

# REMEMBER to .reload during testing

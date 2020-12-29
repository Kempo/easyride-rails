# query to organize riders and drivers (manually clear cars + reassign?)
# find a way to keep state of current assignments before/after changes
# mutations to CRUD riders and drivers and their preferences

class Driver < Person
  has_one :car, inverse_of: :driver, dependent: :destroy
  delegate :riders, :riders_count, :clear_space, to: :car

  has_many :associations, class_name: 'Preference', as: :preferrer, dependent: :destroy
  has_many :preferences, through: :associations, source: :preferable, source_type: 'Rider'

  after_create :create_car!

  scope :available, -> { joins(:car).where('riders_count < ?', :total_space) }

  def add_passenger(rider:)
    riders << rider if car.has_space?
  end

  def remove_passenger(rider:) 
    riders.delete(rider) if riders.exists?(rider.id)
  end
end

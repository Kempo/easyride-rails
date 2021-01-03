class Driver < Person
  has_one :car, inverse_of: :driver, dependent: :destroy
  delegate :riders, :riders_count, :clear_space, to: :car

  has_many :associations, -> { order(created_at: :ASC) }, class_name: 'Preference', as: :preferrer, dependent: :destroy
  has_many :preferences, through: :associations, source: :preferable, source_type: 'Rider'

  after_create :create_car!

  scope :available, -> { joins(:car).where('riders_count < ?', :total_space) }

  def clear_space
    riders.delete_all if riders_count > 0
  end

  def add_passenger(rider:)
    riders << rider if car.has_space?
  end

  def remove_passenger(rider:) 
    riders.delete(rider) if riders.exists?(rider.id)
  end
end

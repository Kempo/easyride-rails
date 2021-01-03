class Rider < Person
  belongs_to :car, inverse_of: :riders, optional: true, counter_cache: true
 
  has_many :associations, -> { order(created_at: :ASC) }, class_name: 'Preference', as: :preferrer, dependent: :destroy
  has_many :preferences, through: :associations, source: :preferable, source_type: 'Driver'

  scope :unassigned, -> { where(car: nil) }

  def prefers_strongest?(driver:)
    preferences.available.first == driver
  end

  def is_taken?
    car.nil?
  end
end

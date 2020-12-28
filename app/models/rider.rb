class Rider < Person
  belongs_to :car, inverse_of: :riders, optional: true, counter_cache: true
 
  has_many :associations, class_name: 'Preference', as: :preferrer, dependent: :destroy
  has_many :preferences, -> { order 'created_at ASC' }, through: :associations, source: :preferable, source_type: 'Driver'

  scope :unassigned, -> { where(car: nil) }

  def prefers_strongest?(driver:)
    preferences.where('riders_count < total_space') == driver
  end
end

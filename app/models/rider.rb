class Rider < Person
  belongs_to :car, inverse_of: :riders, optional: true
 
  has_many :associations, class_name: 'Preference', as: :preferrer, dependent: :destroy
  has_many :preferences, through: :associations, source: :preferable, source_type: 'Driver'

  scope :unassigned, -> { where(car: nil) }
  scope :ordered_preferences, -> { order(created_at: :desc) }
end

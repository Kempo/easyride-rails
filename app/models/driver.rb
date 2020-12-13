class Driver < Person
  has_one :car, inverse_of: :driver, dependent: :destroy
  has_many :riders, through: :car

  has_many :associations, class_name: 'Preference', as: :preferrer, dependent: :destroy
  has_many :preferences, through: :associations, source: :preferable, source_type: 'Rider'
end

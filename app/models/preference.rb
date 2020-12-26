class Preference < ApplicationRecord
  belongs_to :preferrer, polymorphic: true, required: true
  belongs_to :preferable, polymorphic: true, required: true
end
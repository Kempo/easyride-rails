class Preference < ApplicationRecord
  belongs_to :preferrer, polymorphic: true, required: true
  belongs_to :preferable, polymorphic: true, required: true
end

# should be added automatically since polymorphic: true in migration?
# add preferrer_type to Preference table
# add preferable_type to Preference table
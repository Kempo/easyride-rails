module Types
  class RiderType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :address, String, null: false
    field :preferences, [DriverType], null: false
  end
end
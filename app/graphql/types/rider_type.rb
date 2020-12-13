module Types
  class RiderType < Types::BaseObject
    field :name, String, null: false
    field :address, String, null: false
    field :preferences, [DriverType], null: false
  end
end
module Types
  class DriverType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :address, String, null: false
    field :preferences, [RiderType], null: false
    field :car, CarType, null: false
  end
end
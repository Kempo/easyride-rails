module Types
  class DriverType < Types::BaseObject
    implements Types::Person

    field :preferences, [RiderType], null: false
    field :car, CarType, null: false
  end
end
module Types 
  class CarType < Types::BaseObject
    field :driver, DriverType, null: false
    field :riders, [RiderType], null: false 
  end
end
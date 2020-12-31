module Types 
  class CarType < Types::BaseObject
    field :id, ID, null: false
    field :driver, DriverType, null: false
    field :riders, [RiderType], null: false 
  end
end
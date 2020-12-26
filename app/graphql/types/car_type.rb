module Types 
  class CarType < Types::BaseObject
    field :driver, DriverType, null: false
    field :riders, [Rider], null: false 
  end
end
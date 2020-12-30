module Types
  class MutationType < Types::BaseObject
    field :add_rider, mutation: Mutations::AddRider
    field :add_driver, mutation: Mutations::AddDriver
  end
end

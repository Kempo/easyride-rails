module Types
  class MutationType < Types::BaseObject
    field :add_rider, mutation: Mutations::AddRider
  end
end

module Types 
  class CarType < Types::BaseObject
    field :id, ID, null: false
    field :driver, DriverType, null: false # TODO: batching
    field :riders, resolver: Resolvers::SimpleAssociationResolver
  end
end
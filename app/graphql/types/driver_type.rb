module Types
  class DriverType < Types::BaseObject
    implements Types::Person

    field :preferences, resolver: Resolvers::SimpleAssociationResolver
    field :car, CarType, null: false
  end
end
module Types
  class RiderType < Types::BaseObject
    implements Types::Person

    field :preferences, resolver: Resolvers::SimpleAssociationResolver
  end
end
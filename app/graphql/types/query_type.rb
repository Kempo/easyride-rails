module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :all_riders, [RiderType], null: true,
      description: "Returns all the submitted riders."

    field :all_drivers, [DriverType], null: true,
      description: "Returns all the submitted drivers."

    def all_riders
      Rider.all
    end

    def all_drivers
      Driver.all
    end
  end
end

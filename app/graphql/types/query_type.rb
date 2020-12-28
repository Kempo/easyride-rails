module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :all_riders, [RiderType], null: true,
      description: "All the riders."

    field :all_drivers, [DriverType], null: true,
      description: "All the drivers."
    
    field :organize, [CarType], null: true,
      description: "Driver and rider car assignments."

    def all_riders
      Rider.all
    end

    def all_drivers
      Driver.all
    end

    def organize
      # clear all car occupants
      # TODO: match riders and drivers
      
      nil
    end
  end
end

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
      Driver.find_each(&:clear_space)

      untaken = Rider.unassigned
      open_drivers = Driver.available

      # assume enough seats for all riders
      while untaken.reload.size > 0
        cur = untaken.first

        open_drivers.reload.each do |driver|
          if cur.prefers_strongest?(driver: driver)
            driver.add_passenger(rider: cur)
          end
        end

        untaken.rotate! if cur.car.nil?
      end

      Car.all
    end
  end
end

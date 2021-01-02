module Resolvers
  class TestResolver < Resolvers::BaseResolver
    type [Types::DriverType], null: false

    def resolve 
      # puts "HELLO!"
      # puts "#{object.inspect}"

      loader = PreferenceLoader.for(Rider, :preferences).load(object)

      # loader.load(object)
    end

    # Loaders represent promises and mechanism to 
    # postpone loading until we have all riders in the list
    class PreferenceLoader < GraphQL::Batch::Loader
      def initialize(model, association_name)
        @model = model
        @association_name = association_name
      end

      # perform called with all the riders
      def perform(riders)
        # this is the built-in active record mechanism to 
        # preload associations into a group of records
        # association are loaded with the minimum amount of queries
        ::ActiveRecord::Associations::Preloader.new.preload(riders, @association_name)
        
        riders.each do |rider|
          puts "HI \n #{rider.inspect}"
          # returns topics for every post in the list
          fulfill rider, read_association(rider)
        end
      end

      private 

      def read_association(record)
        record.public_send(@association_name)
      end
    end
  end
end
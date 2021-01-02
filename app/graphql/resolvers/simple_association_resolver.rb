module Resolvers
  class SimpleAssociationResolver < Resolvers::BaseResolver
    type [Types::Person], null: false

    def resolve 
      # object = record
      loader = PreferenceLoader.for(object.class, :preferences).load(object)
    end

    # Loaders represent promises and mechanism to 
    # postpone loading until we have all riders in the list
    class PreferenceLoader < GraphQL::Batch::Loader
      def initialize(model, association_name)
        @model = model
        @association_name = association_name
      end

      # Load each individual record (eg. a Rider hash)
      def load(record)
        raise TypeError, "#{@model} loader can't load association for #{record.class}" unless record.is_a?(@model)
        return Promise.resolve(read_association(record)) if association_loaded?(record)
        super
      end

      def perform(records)
        # this is the built-in active record mechanism to 
        # preload associations into a group of records
        # association are loaded with the minimum amount of queries
        ::ActiveRecord::Associations::Preloader.new.preload(records, @association_name)
        
        records.each do |record|
          # fulfills the promise for the specific record with the requested association
          fulfill(record, read_association(record))
        end
      end

      # We want to load the associations on all records, even if they have the same id
      def cache_key(record)
        record.object_id
      end

      private 

      def read_association(record)
        record.public_send(@association_name)
      end

      def association_loaded?(record)
        record.association(@association_name).loaded?
      end
    end
  end
end
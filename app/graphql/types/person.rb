module Types::Person
  include Types::BaseInterface

  field :id, ID, null: false
  field :name, String, null: false
  field :address, String, null: false

  definition_methods do 
    def resolve_type(object, context) 
      if object.is_a?(::Driver)
        Types::DriverType
      elsif object.is_a?(::Rider)
        Types::RiderType
      else
        raise "Unexpected Person: #{object.inspect}"
      end
    end
  end
end
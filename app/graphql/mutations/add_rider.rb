module Mutations
  class AddRider < BaseMutation
    null true
  
    argument :name, String, required: true
    argument :address, String, required: true
    argument :preferences, [ID], required: true
  
    field :rider, Types::RiderType, null: true
    field :errors, [String], null: false
  
    def resolve(name:, address:, preferences:)
      # TODO: ideally, we'd auto-generate preferences on model creation
      matched = Driver.where(id: preferences)
      
      rider = Rider.build(name: name, address: address, car: nil)
  
      return {
        rider: nil,
        errors: rider.errors.full_messages # add pref error msg
      } unless matched.length == preferences.length && rider.save
      
      # TODO: simplify.
      matched.each do |driver|
        Preference.create(
          preferrer: rider,
          preferable: driver
        )
      end
  
      {
        rider: rider,
        errors: []
      }
    end
  end

end
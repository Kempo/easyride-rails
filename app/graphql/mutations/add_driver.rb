module Mutations
  class AddDriver < BaseMutation
    null true
  
    argument :name, String, required: true
    argument :address, String, required: true
    argument :preferences, [ID], required: true
    argument :total_space, Int, required: true
  
    field :driver, Types::DriverType, null: true
    field :errors, [String], null: false
  
    def resolve(name:, address:, preferences:, total_space:)
      matched = Rider.where(id: preferences)
  
      if matched.length != preferences.length
        {
          driver: nil,
          errors: ['There is an invalid id provided in the preferences.']
        }
      end
      
  
      driver = Driver.create(
        name: name, 
        address: address, 
        total_space: total_space
      )
  
      return {
        driver: nil,
        errors: driver.errors.full_messages
      } unless driver
      
      # yikes! TODO: fix.
      matched.each do |rider|
        Preference.create(
          preferrer: driver,
          preferable: rider
        )
      end
  
      {
        rider: driver,
        errors: []
      }
    end
  end
end

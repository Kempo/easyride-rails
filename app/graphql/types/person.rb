module Types::Person
  include Types::BaseInterface

  field :id, ID, null: false
  field :name, String, null: false
  field :address, String, null: false
end
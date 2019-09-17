class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :address, :city, :state
  has_many :experiences
end

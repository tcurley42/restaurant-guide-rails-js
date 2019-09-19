class ExperienceSerializer < ActiveModel::Serializer
  attributes :id, :description, :rating, :user
  belongs_to :restaurant
  belongs_to :user
end

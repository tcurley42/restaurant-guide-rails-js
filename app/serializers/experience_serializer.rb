class ExperienceSerializer < ActiveModel::Serializer
  attributes :id, :description, :rating, :user_id
  belongs_to :restaurant
  belongs_to :user
end

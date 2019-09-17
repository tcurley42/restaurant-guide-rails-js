class Experience < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  accepts_nested_attributes_for :restaurant
end

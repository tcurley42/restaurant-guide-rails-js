class User < ApplicationRecord
  validates :name, uniqueness: true
  validates :password_digest, presence: true
  has_secure_password
  has_many :experiences
  has_many :restaurants, through: :experiences
end

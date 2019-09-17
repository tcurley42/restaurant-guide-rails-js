class Restaurant < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :phone, format: { with: /\A\(?\d{3}\)?[- ]?\d{3}[- ]?\d{4}\z/,
                              message: "must be in the format (xxx) xxx-xxxx or xxx-xxx-xxxx"}
  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10}
  has_many :experiences
  has_many :users, through: :experiences
  accepts_nested_attributes_for :experiences

  scope :denver, -> {where(city: "Denver")}
  scope :highest_price, -> {order('price desc').limit(5)}
  scope :lowest_price, -> {order('price asc').limit(5)}
  scope :most_frequented, -> {joins(:experiences).group('restaurant_id').order("count(experiences.restaurant_id) desc").limit(2)}
  def avg_rating
    if !self.experiences.empty?
      self.experiences.average(:rating).round(2)
    else
      "No ratings yet!"
    end
  end
end

class CreateExperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :experiences do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.string :description
      t.decimal :rating

      t.timestamps
    end
  end
end

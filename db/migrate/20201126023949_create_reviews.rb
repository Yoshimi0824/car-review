class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :automaker_id,           null: false
      t.string :model_of_car,            null: false
      t.string :grade,                   null: false
      t.integer :era_name_id,            null: false
      t.integer :model_year
      t.integer :design_id,              null: false
      t.integer :driving_performance_id, null: false
      t.integer :ride_comfort_id,        null: false
      t.integer :lording_id,             null: false
      t.integer :fuel_economy_id,        null: false
      t.integer :price_id,               null: false
      t.text :good_point,                null: false
      t.text :bad_point,                 null: false
      t.references :user,                foreign_key: true
      t.timestamps
    end
  end
end

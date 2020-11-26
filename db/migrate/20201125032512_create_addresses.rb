class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :postal_code,        null: false
      t.integer :prefecture_id,     null: false
      t.string :municipality,       null: false
      t.string :street_number,      null: false
      t.string :building_name,      null: false
      t.references :user,           foreign_key: true
      t.timestamps
    end
  end
end

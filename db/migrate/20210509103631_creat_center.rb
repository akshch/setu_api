class CreatCenter < ActiveRecord::Migration[6.1]
  def change
    create_table :centers do |t|
      t.integer :center_id
      t.string :name
      t.text :address
      t.string :state_name
      t.string :district_name
      t.string :block_name
      t.integer :pincode
      t.string :from
      t.string :to
      t.integer :lat
      t.integer :long
      t.string :fee_type
      t.string :session_id
      t.date :date
      t.string :available_capacity
      t.decimal :fee
      t.integer :min_age_limit
      t.string :vaccine

      t.timestamps
    end
  end
end

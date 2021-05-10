class CreateSlot < ActiveRecord::Migration[6.1]
  def change
    create_table :slots do |t|
      t.string :timing
      t.references :center
      t.timestamps
    end
  end
end

class CreateEditions < ActiveRecord::Migration
  def change
    create_table :editions do |t|
      t.date :start
      t.date :finish
      t.string :location
      t.boolean :active
      t.integer :seats
      t.integer :price_in_cents
      t.references :course

      t.timestamps
    end
    add_index :editions, :course_id
  end
end

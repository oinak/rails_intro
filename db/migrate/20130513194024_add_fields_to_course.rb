class AddFieldsToCourse < ActiveRecord::Migration

  def up
    add_column :courses, :active, :boolean, :default => false, :null => false
    add_column :courses, :start_date, :date
    add_column :courses, :location, :string
    Course.update_all(:location => 'Calle de la Paz 4, 28012 Madrid')
  end

  def down
    remove_column :courses, :location
    remove_column :courses, :active
    remove_column :courses, :start_date
  end

end

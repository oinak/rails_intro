class Course < ActiveRecord::Base
  attr_accessible :description, :name
  validates :name, :presence => true
  validates :active, :inclusion => [true, false]

  validates_each :start_date  do |record, attr, value|
    record.errors.add attr, "can't be future if active" if value < Date.today && record.active?
  end

end

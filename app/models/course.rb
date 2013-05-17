class Course < ActiveRecord::Base
  attr_accessible :description, :name
  validates :name, :presence => true
  has_many :editions, :inverse_of => :course

end

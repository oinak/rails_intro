class Course < ActiveRecord::Base
  attr_accessible :description, :name
  validates :name, :presence => true
  has_many :editions, :inverse_of => :course

  scope :filtered, lambda { |f|
    if f.nil?
      where({})
    else
      includes(:editions).where("editions.active = ?", f=='active')
    end
  }
end

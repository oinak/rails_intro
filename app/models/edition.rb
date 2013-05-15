class Edition < ActiveRecord::Base
  belongs_to :course
  attr_accessible :active, :finish, :location, :price_in_cents, :seats, :start
end

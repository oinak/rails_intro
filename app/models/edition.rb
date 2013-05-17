class Edition < ActiveRecord::Base
  belongs_to :course, :inverse_of => :editions
  attr_accessible :active, :finish, :location, :price, :seats, :start

  # Validación personalizada (each)
  validates_each :start do |record, attr, value|
    error_cond = value && value < Date.today && record.active?
    record.errors.add(attr, 'must happen in the future if active') if error_cond
  end

  # validacion con metodo/simbolo
  validate :validate_end_date_before_start_date

  def location_map_link
    location.blank? ? '' : "http://maps.google.es/?q=" + CGI.escape(location)
  end

  def price
    self.price_in_cents.to_i / 100.0
  end

  def price=(val = 0)
    self.price_in_cents= (val.to_f * 100).to_i
  end

private
  def validate_end_date_before_start_date
    if finish && start
      errors.add(:finish, "Put error text here") if finish < start
    end
  end

end

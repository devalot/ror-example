class Refuel < ActiveRecord::Base
  
  ##############################################################################
  attr_accessible(:refueled_at, :odometer, :gallons, :price)
  
  ##############################################################################
  validates(:refueled_at, :presence => true)
  validates(:odometer,    :presence => true, :numericality => true)
  validates(:gallons,     :presence => true, :numericality => true)
  validates(:price_cents, :presence => true, :numericality => true)
  
  ##############################################################################
  # We're going to use the money gem to map the price_cents attribute
  # to a Money object.  To make the price_cents attribute
  # transparently appear as a Money object through the price attribute
  # we need to tell ActiveRecord how to do the conversion.
  #
  # After we use the `composed_of` call below we can read and write a
  # Money object on the price attribute and it will automatically be
  # converted to and from our integer attribute price_cents.
  composed_of(:price, 
              :class_name  => "Money",                                 
              :mapping     => [%w(price_cents cents)],                    
              :constructor => lambda {|cents| Money.new(cents || 0)}, 
              :converter   => lambda {|value| value.to_money})
  
  ##############################################################################
  belongs_to(:car) # refuel.car
  
  ##############################################################################
  # A scope is a way to give a name to database query so it can be
  # accessed by other models, controllers, and views.  You can see
  # this being used in app/views/cars/index.html.erb.
  scope(:most_recent, order('refueled_at DESC').limit(1))
  
  ##############################################################################
  # This method is used to find a refuel that occurred just prior to
  # this one.  We'll use this later to calculate MPG and distance
  # based on the previous refuel.
  def preceding
    car.refuels.where('refueled_at < ?', refueled_at).order('refueled_at DESC').first
  end

  ##############################################################################
  # Returns the refuel that happened after this one.  See also:
  # preceding.
  def following
    car.refuels.where('refueled_at > ?', refueled_at).order('refueled_at').first
  end
  
  ##############################################################################
  def formatted_mpg
    "%.2f" % [mpg || 0.0]
  end
  
  ##############################################################################
  def cost_per_mile
    if other = preceding
      preceding.price / distance
    end
  end
  
  ##############################################################################
  private
  
  ##############################################################################
  # A private instance method to calculate and cache the mpg and
  # distance fields using the refuel that happened prior to this one.
  def cache_mpg_and_distance
    if other = preceding
      self.distance = odometer - preceding.odometer
      self.mpg      = distance / gallons
    end
  end
  
  ##############################################################################
  # This callback will only be invoked when a new record is being
  # saved for the first time.
  before_create do
    cache_mpg_and_distance if distance.blank? or mpg.blank?
  end
end

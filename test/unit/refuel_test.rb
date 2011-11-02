################################################################################
require('test_helper')

################################################################################
class RefuelTest < ActiveSupport::TestCase
  
  ##############################################################################
  test "make sure composed_of money is working" do
    refuel = Refuel.new
    refuel.price_cents = 100
    assert_equal("1.00".to_money, refuel.price)
    
    refuel.price = "2.50"
    assert_equal("2.50".to_money, refuel.price)
    assert_equal(refuel.price_cents, 250)
  end
  
  ##############################################################################
  test "preceding and following methods" do
    make_a_bunch_of_refuels

    refuel = @car.refuels.where(:refueled_at => @dates[2]).first
    assert(refuel)
    
    preceding = refuel.preceding
    assert(preceding)
    assert_equal(@dates[1], preceding.refueled_at)
    
    following = refuel.following
    assert(following)
    assert_equal(@dates[3], following.refueled_at)
  end
  
  ##############################################################################
  test "caching of mpg and distance" do
    make_a_bunch_of_refuels

    # The first refuel won't have any mpg info
    first = @car.refuels.where(:refueled_at => @dates[0]).first
    assert(first)
    assert(first.mpg.blank?)
    assert(first.distance.blank?)
    
    # All others should have the same mpg and distance because we
    # created them that way.
    (1...@dates.size).each do |index|
      refuel = @car.refuels.where(:refueled_at => @dates[index]).first
      assert(refuel)
      assert_equal(100, refuel.distance)
      assert_equal("9.62", "%.2f" % [refuel.mpg])
    end
  end
  
  ##############################################################################
  private
  
  ##############################################################################
  def make_a_bunch_of_refuels
    @dates = [
      '2011-08-01 10:30:00',
      '2011-08-06 14:51:00',
      '2011-09-01 13:16:00',
      '2011-09-16 14:56:00',
      '2011-10-01 20:01:00',
    ].map {|date| Time.parse(date)}
    
    @car = FactoryGirl.create(:car)
    odometer = 160809
    distance = 100
    
    @dates.each do |date|
      @car.refuels.create!(:refueled_at => date,    
                         :odometer      => odometer, 
                         :gallons       => 10.4,     
                         :price         => '50.24')

      odometer += distance
    end
  end
end

require_relative '../../lib/paymentrails'
require 'test/unit'

class PaymentRailsTest < Test::Unit::TestCase
  def test_client
    PaymentRails.client('key', 'secret', 'environment')
  end
end

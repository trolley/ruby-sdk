# rubocop:disable Layout/EndOfLine
require_relative '../test_helper'

class BalanceTest < Test::Unit::TestCase
  include TestHelper

  def test_find
    with_vcr do
      balances = @client.balance.find
      assert_true(balances.balances.count > 0)
      assert_not_nil(balances.balances[0].type)
    end
  end

  def test_find_with_term
    with_vcr do
      balances = @client.balance.find('paymentrails')
      assert_true(balances.balances.count > 0)
      assert_not_nil(balances.balances[0].type)
      assert_equal('paymentrails', balances.balances[0].type)
    end
  end
end
# rubocop:enable Layout/EndOfLine

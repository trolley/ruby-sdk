# rubocop:disable Layout/EndOfLine
require_relative 'helper'

class BalanceTest < Test::Unit::TestCase
  include ApiClientHelper

  def test_find
    balances = @client.balance.find
    assert_true(balances.balances.count > 0)
    assert_not_nil(balances.balances[0].type)
  end

  def test_find_with_term
    balances = @client.balance.find('paymentrails')
    assert_true(balances.balances.count > 0)
    assert_not_nil(balances.balances[0].type)
    assert_equal('paymentrails', balances.balances[0].type)
  end
end
# rubocop:enable Layout/EndOfLine

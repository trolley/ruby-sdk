require_relative 'helper'

class BalanceTest < Test::Unit::TestCase
  def setup
    @client = PaymentRails.client(
      ENV.fetch('SANDBOX_API_KEY'),
      ENV.fetch('SANDBOX_SECRET_KEY'),
      ENV.fetch('TROLLEY_ENVIRONMENT'),
      proxy_uri: ENV['PROXY_URI']
    )
  end

  def test_find
    balances = @client.balance.find.balances

    assert_true balances.count > 0

    assert_equal(balances.first.class, OpenStruct)
    assert_not_nil(balances.first.amount)
    assert_not_nil(balances.first.accountNumber)
    assert_not_nil(balances.first.provider)
    assert_not_nil(balances.first.providerAcct)
  end
end
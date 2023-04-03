require_relative 'helper'

class RecipientTest < Test::Unit::TestCase
  def setup
    @client = PaymentRails.client(
      ENV.fetch('SANDBOX_API_KEY'),
      ENV.fetch('SANDBOX_SECRET_KEY'),
      'production',
      proxy_uri: ENV['PROXY_URI']
    )
  end

  def test_create
    uuid = SecureRandom.uuid.to_s
    response = @client.recipient.create(
      type: 'individual',
      firstName: 'Tom',
      lastName: 'Jones',
      email: 'test.create' + uuid + '@example.com'
    )
    assert_not_nil(response)
    assert_equal(response.firstName, 'Tom')
    assert_equal(response.lastName, 'Jones')
    assert_not_nil(response.id)
  end

  def test_lifecycle
    uuid = SecureRandom.uuid.to_s
    recipient = @client.recipient.create(
      type: 'individual',
      firstName: 'Tom',
      lastName: 'Jones',
      email: 'test.create' + uuid + '@example.com'
    )
    assert_not_nil(recipient)
    assert_equal(recipient.firstName, 'Tom')
    assert_equal(recipient.status, 'incomplete')

    response = @client.recipient.update(recipient.id, firstName: 'Bob')
    assert_true(response)

    recipient = @client.recipient.find(recipient.id)
    assert_equal(recipient.firstName, 'Bob')

    response = @client.recipient.delete(recipient.id)
    assert_true(response)

    recipient = @client.recipient.find(recipient.id)
    assert_equal(recipient.status, 'archived')
  end

  # rubocop:disable Metrics/MethodLength
  def test_account
    uuid = SecureRandom.uuid.to_s
    recipient = @client.recipient.create(
      type: 'individual',
      firstName: 'Tom',
      lastName: 'Jones',
      email: 'test.create' + uuid + '@example.com',
      address: {
        street1: '123 Wolfstrasse',
        city: 'Berlin',
        country: 'DE',
        postalCode: '123123'
      }
    )
    assert_not_nil(recipient)
    assert_equal(recipient.firstName, 'Tom')
    assert_equal(recipient.lastName, 'Jones')
    assert_not_nil(recipient.id)
    assert_true(recipient.routeMinimum.to_i >= 0)

    account = @client.recipient_account.create(recipient.id, type: 'bank-transfer', currency: 'EUR', country: 'DE', iban: 'DE89 3704 0044 0532 0130 00')
    assert_not_nil(account)

    account = @client.recipient_account.create(recipient.id, type: 'bank-transfer', currency: 'EUR', country: 'FR', iban: 'FR14 2004 1010 0505 0001 3M02 606')
    assert_not_nil(account)

    findAccount = @client.recipient_account.find(recipient.id, account.id)
    assert_equal(account.id, findAccount.id)

    accountList = @client.recipient_account.all(recipient.id)
    assert_equal(2, accountList.count)
    assert_equal(accountList[0].currency, 'EUR')

    result = @client.recipient_account.delete(recipient.id, account.id)
    assert_true(result)

    accountList = @client.recipient_account.all(recipient.id)
    assert_equal(1, accountList.count)
  end
  # rubocop:enable Metrics/MethodLength
end

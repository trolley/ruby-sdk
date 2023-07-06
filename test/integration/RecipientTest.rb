require_relative '../test_helper'

class RecipientTest < Test::Unit::TestCase
  include ApiClientHelper

  def test_create
    response = @client.recipient.create(
      type: 'individual',
      firstName: 'Tom',
      lastName: 'Jones',
      email: "test.create#{uuid}@example.com"
    )
    assert_not_nil(response)
    assert_equal(response.firstName, 'Tom')
    assert_equal(response.lastName, 'Jones')
    assert_not_nil(response.id)
  end

  def test_lifecycle
    recipient = @client.recipient.create(
      type: 'individual',
      firstName: 'Tom',
      lastName: 'Jones',
      email: "test.create#{uuid}@example.com"
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

  def test_account
    recipient = @client.recipient.create(
      type: 'individual',
      firstName: 'Tom',
      lastName: 'Jones',
      email: "test.create#{uuid}@example.com",
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

  def test_delete_multiple
    recipient1 = @client.recipient.create(
      type: 'individual',
      firstName: 'Tom',
      lastName: 'Jones',
      email: "test.create#{uuid}@example.com"
    )
    assert_not_nil(recipient1)
    assert_equal(recipient1.firstName, 'Tom')
    assert_equal(recipient1.status, 'incomplete')

    recipient2 = @client.recipient.create(
      type: 'individual',
      firstName: 'Tom',
      lastName: 'Jones',
      email: "test.create#{uuid}@example.com"
    )
    assert_not_nil(recipient2)
    assert_equal(recipient2.firstName, 'Tom')
    assert_equal(recipient2.status, 'incomplete')

    response = @client.recipient.delete([recipient1.id, recipient2.id])
    assert_true(response)

    recipient1 = @client.recipient.find(recipient1.id)
    assert_equal(recipient1.status, 'archived')

    recipient2 = @client.recipient.find(recipient2.id)
    assert_equal(recipient2.status, 'archived')
  end

  def test_find_logs
    recipient = @client.recipient.create(
      type: 'individual',
      firstName: 'Tom',
      lastName: 'Jones',
      email: "test.create#{uuid}@example.com"
    )
    assert_not_nil(recipient)
    assert_equal(recipient.firstName, 'Tom')
    assert_equal(recipient.status, 'incomplete')

    @client.recipient.update(recipient.id, firstName: 'John')
    logs = @client.recipient.find_logs(recipient.id)

    assert_equal(logs.class, OpenStruct)
    assert_boolean(true, @client.recipient.delete(recipient.id))
  end

  def test_find_payments
    recipient = @client.recipient.create(
      type: 'individual',
      firstName: 'Tom',
      lastName: 'Jones',
      email: "test.create#{uuid}@example.com"
    )
    recipient_account = @client.recipient_account.create(recipient.id, type: 'bank-transfer', currency: 'EUR', country: 'DE', iban: 'DE89 3704 0044 0532 0130 00')

    batch = @client.batch.create(
      sourceCurrency: 'USD', description: 'Integration Test Payments', payments: [
        { targetAmount: '10.00', targetCurrency: 'EUR', recipient: { id: recipient.id } },
        { sourceAmount: '10.00', recipient: { id: recipient.id } }
      ]
    )

    payments = @client.recipient.find_payments(recipient.id)
    assert_equal(payments.count, 2)
    assert_equal(payments[0].recipient['id'], recipient.id)
    assert_equal(payments[1].recipient['id'], recipient.id)
    assert_equal(payments.map(&:amount), ['10.00', '10.00'])

    assert_boolean(true, @client.batch.delete(batch.id))
    assert_boolean(true, @client.recipient_account.delete(recipient.id, recipient_account.id))
    assert_boolean(true, @client.recipient.delete(recipient.id))
  end
end
# rubocop:enable Metrics/ClassLength

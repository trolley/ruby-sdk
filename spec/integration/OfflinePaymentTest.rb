require_relative 'helper'

class OfflinePaymentTest < Test::Unit::TestCase
  include ApiClientHelper

  def create_recipient
    uuid = SecureRandom.uuid.to_s
    recipient = @client.recipient.create(
      type: 'individual',
      firstName: 'Tom',
      lastName: 'Jones',
      email: "test.batch#{uuid}@example.com",
      address: {
        street1: '123 Wolfstrasse',
        city: 'Berlin',
        country: 'DE',
        postalCode: '123123'
      }
    )
    @client.recipient_account.create(recipient.id, type: 'bank-transfer', currency: 'EUR', country: 'DE', iban: 'DE89 3704 0044 0532 0130 00')
    recipient
  end

  def test_create
    recipient = create_recipient
    offline_payment = @client.offline_payment.create(
      recipient.id,
      {
        amount: '10.00',
        currency: 'EUR'
      }
    )

    assert_not_nil(offline_payment)
    assert_not_nil(offline_payment.id)
    assert_equal('10.00', offline_payment.amount)
    assert_equal('EUR', offline_payment.currency)
  end

  def test_update
    recipient = create_recipient
    offline_payment = @client.offline_payment.create(
      recipient.id,
      {
        amount: '10.00',
        currency: 'EUR',
        category: 'services'
      }
    )

    assert_not_nil(offline_payment)

    response = @client.offline_payment.update(
      recipient.id,
      offline_payment.id,
      {
        category: 'royalties'
      }
    )

    assert_true(response)
  end

  def test_delete
    recipient = create_recipient
    offline_payment = @client.offline_payment.create(
      recipient.id,
      {
        amount: '10.00',
        currency: 'EUR',
        category: 'services'
      }
    )

    assert_not_nil(offline_payment)

    response = @client.offline_payment.delete(recipient.id, offline_payment.id)

    assert_true(response)
  end

  def test_search
    recipient = create_recipient
    offline_payment = @client.offline_payment.create(
      recipient.id,
      {
        amount: '10.00',
        currency: 'EUR',
        category: 'services'
      }
    )

    assert_not_nil(offline_payment)

    offline_payments = @client.offline_payment.search(
      recipient.id
    )

    assert_true(offline_payments.count > 0)
  end
end

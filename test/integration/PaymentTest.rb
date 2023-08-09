require_relative '../test_helper'

class PaymentTest < Test::Unit::TestCase
  include TestHelper

  def recipient
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

  def batch
    @batch ||= @client.batch.create(sourceCurrency: 'USD', description: 'Integration Test Create')
  end

  def test_crud
    with_vcr do
      payment = @client.payment.create(
        batch.id,
        sourceAmount: '10.00',
        sourceCurrency: 'USD',
        recipient: { id: recipient.id }
      )

      assert_not_nil(payment)
      assert_not_nil(payment.id)
      assert_equal('10.00', payment.sourceAmount)
      assert_equal('USD', payment.sourceCurrency)

      payment = @client.payment.find(batch.id, payment.id)
      assert_not_nil(payment)

      update_response = @client.payment.update(
        batch.id,
        payment.id,
        sourceAmount: '20.00',
        sourceCurrency: 'USD'
      )

      assert_not_nil(update_response)

      response = @client.payment.delete(batch.id, payment.id)
      assert_true(response)
    end
  end

  def test_search
    with_vcr do
      @client.payment.create(
        batch.id,
        sourceAmount: '10.00',
        sourceCurrency: 'USD',
        recipient: { id: recipient.id }
      )

      result = @client.payment.search(batch.id)
      assert_not_nil(result)
      assert_true(result.count > 0)
    end
  end
end

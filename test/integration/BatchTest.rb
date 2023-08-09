require_relative '../test_helper'
class BatchTest < Test::Unit::TestCase
  include TestHelper

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
    with_vcr do
      batch = @client.batch.create(sourceCurrency: 'USD', description: 'Integration Test Create')
      assert_not_nil(batch)
      assert_not_nil(batch.id)

      batch = @client.batch.all
      assert_true(batch.count.positive?)
    end
  end

  def test_update
    with_vcr do
      batch = @client.batch.create(sourceCurrency: 'USD', description: 'Integration Test Create')
      assert_not_nil(batch)
      assert_not_nil(batch.id)

      all = @client.batch.all
      assert_true(all.count.positive?)

      response = @client.batch.update(batch.id, description: 'Integration Update')
      assert_true(response)
      findBatch = @client.batch.find(batch.id)
      assert_equal('Integration Update', findBatch.description)
      assert_equal('open', batch.status)

      response = @client.batch.delete(batch.id)
      assert_true(response)
    end
  end

  def test_create_with_payments
    with_vcr do
      recipientAlpha = create_recipient
      recipientBeta = create_recipient

      batch = @client.batch.create(
        sourceCurrency: 'USD', description: 'Integration Test Payments', payments: [
          { targetAmount: '10.00', targetCurrency: 'EUR', recipient: { id: recipientAlpha.id } },
          { sourceAmount: '10.00', recipient: { id: recipientBeta.id } }
        ]
      )

      assert_not_nil(batch)
      assert_not_nil(batch.id)

      findBatch = @client.batch.find(batch.id)
      assert_not_nil(findBatch)
      assert_equal(2, findBatch.totalPayments)

      payments = @client.payment.search(batch.id)
      payments.each { |item| assert_equal('pending', item.status) }
    end
  end

  def test_payments
    with_vcr do
      batch = @client.batch.create(sourceCurrency: 'USD', description: 'Integration Test Payments')
      assert_not_nil(batch)
      assert_not_nil(batch.id)

      recipient = create_recipient

      payment = @client.payment.create(batch.id, sourceAmount: '10.00', recipient: { id: recipient.id })

      assert_not_nil(payment)
      assert_not_nil(payment.id)

      response = @client.payment.update(batch.id, payment.id, sourceAmount: '20.00')
      assert_true(response)

      response = @client.payment.delete(batch.id, payment.id)
      assert_true(response)
    end
  end

  def test_processing
    with_vcr do
      recipientAlpha = create_recipient
      recipientBeta = create_recipient

      batch = @client.batch.create(
        sourceCurrency: 'USD', description: 'Integration Test Payments', payments: [
          { targetAmount: '10.00', targetCurrency: 'EUR', recipient: { id: recipientAlpha.id } },
          { sourceAmount: '10.00', recipient: { id: recipientBeta.id } }
        ]
      )
      assert_not_nil(batch)
      assert_not_nil(batch.id)

      summary = @client.batch.summary(batch.id)
      assert_equal(2, summary.detail['bank-transfer']['count'])

      quote = @client.batch.generate_quote(batch.id)
      assert_not_nil(quote)

      start = @client.batch.start_processing(batch.id)
      assert_not_nil(start)
    end
  end

  def test_delete_multiple
    with_vcr do
      batch = @client.batch.create(sourceCurrency: 'USD', description: 'Integration Test Create')
      assert_not_nil(batch)
      assert_not_nil(batch.id)

      batch2 = @client.batch.create(sourceCurrency: 'USD', description: 'Integration Test Create')
      assert_not_nil(batch2)
      assert_not_nil(batch2.id)

      response = @client.batch.delete([batch.id, batch2.id])
      assert_true(response)
    end
  end
end

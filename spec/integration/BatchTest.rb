require_relative 'helper'

class BatchTest < Test::Unit::TestCase
  def setup
    @client = PaymentRails.client(
      ENV.fetch('SANDBOX_API_KEY'),
      ENV.fetch('SANDBOX_SECRET_KEY'),
      'production',
      proxy_uri: ENV['PROXY_URI']
    )
  end

  def create_recipient
    uuid = SecureRandom.uuid.to_s
    recipient = @client.recipient.create(
      type: 'individual',
      firstName: 'Tom',
      lastName: 'Jones',
      email: 'test.batch' + uuid + '@example.com',
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
    batch = @client.batch.create(sourceCurrency: 'USD', description: 'Integration Test Create')
    assert_not_nil(batch)
    assert_not_nil(batch.id)

    batch = @client.batch.all
    assert_true(batch.count > 0)
  end

  def test_update
    batch = @client.batch.create(sourceCurrency: 'USD', description: 'Integration Test Create')
    assert_not_nil(batch)
    assert_not_nil(batch.id)

    all = @client.batch.all
    assert_true(all.count > 0)

    response = @client.batch.update(batch.id, description: 'Integration Update')
    assert_true(response)
    findBatch = @client.batch.find(batch.id)
    assert_equal('Integration Update', findBatch.description)
    assert_equal('open', batch.status)

    response = @client.batch.delete(batch.id)
    assert_true(response)
  end

  def test_create_with_payments
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

  def test_payments
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

  def test_processing
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

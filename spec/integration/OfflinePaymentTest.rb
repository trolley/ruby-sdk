require_relative 'helper'

class OfflinePaymentTest < Test::Unit::TestCase
  def setup
    @client = PaymentRails.client(
      ENV.fetch('SANDBOX_API_KEY'),
      ENV.fetch('SANDBOX_SECRET_KEY'),
      ENV.fetch('TROLLEY_ENVIRONMENT'),
      proxy_uri: ENV['PROXY_URI']
    )
  end

  def test_create
    recipient, offline_payment = create_offline_payment!

    assert_equal(offline_payment.class, PaymentRails::OfflinePayment)
    assert_equal(offline_payment.amount, "100.00")
    assert_equal(offline_payment.withholdingAmount, "0.00")
    assert_equal(offline_payment.currency, 'USD')
    assert_equal(offline_payment.externalId, '12345')

    assert_true @client.offline_payment.delete(recipient.id, offline_payment.id)
    assert_true @client.recipient.delete(recipient.id)
  end

  # def test_update
  #   recipient, offline_payment = create_offline_payment!
  #
  #   @client.offline_payment.update(
  #     recipient.id,
  #     offline_payment.id,
  #     amount: "200.00",
  #     currency: 'EUR',
  #     withholdingAmount: "10.00",
  #     withholdingCurrency: 'EUR',
  #     externalId: "54321"
  #   )
  #
  #   offline_payment = @client.offline_payment.search(recipient.id, 1, 10, "id=#{offline_payment.id}").first
  #
  #   # TODO: Figure out search format
  #
  #   assert_equal(offline_payment.class, PaymentRails::OfflinePayment)
  #   assert_equal(offline_payment.amount, "200.00")
  #   assert_equal(offline_payment.currency, 'EUR')
  #   assert_equal(offline_payment.withholdingAmount, "10.00")
  #   assert_equal(offline_payment.withholdingCurrency, 'EUR')
  #   assert_equal(offline_payment.externalId, "54321")
  #
  #   assert_true @client.offline_payment.delete(recipient.id, offline_payment.id)
  #   assert_true @client.recipient.delete(recipient.id)
  # end

  def test_delete
    recipient, offline_payment = create_offline_payment!

    assert_true @client.offline_payment.delete(recipient.id, offline_payment.id)
    assert_true @client.recipient.delete(recipient.id)
  end

  private

  def create_offline_payment!
    uuid = SecureRandom.uuid.to_s
    recipient = @client.recipient.create(
      firstName: 'John',
      lastName: 'Doe',
      email: "john.doe+#{uuid}@example.com",
      type: 'individual',
      )

    offline_payment = @client.offline_payment.create(
      recipient.id,
      amount: "100",
      currency: 'USD',
      withholdingAmount: "0",
      withholdingCurrency: 'USD',
      payoutMethod: 'other',
      externalId: '12345'
    )

    return recipient, offline_payment
  end
end

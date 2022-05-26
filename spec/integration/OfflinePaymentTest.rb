require_relative 'helper'

class OfflinePaymentTest < Test::Unit::TestCase
  DEFAULT_PAYMENT_AMOUNT = "100.00"
  DEFAULT_PAYMENT_CURRENCY = "USD"
  DEFAULT_PAYMENT_WITHHOLDING_AMOUNT = "0.00"
  DEFAULT_PAYMENT_WITHHOLDING_CURRENCY = "USD"
  DEFAULT_PAYMENT_PAYOUT_METHOD = "other"
  DEFAULT_PAYMENT_EXTERNAL_ID = "12345"

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
    assert_equal(offline_payment.amount, DEFAULT_PAYMENT_AMOUNT)
    assert_equal(offline_payment.withholdingAmount, DEFAULT_PAYMENT_WITHHOLDING_AMOUNT)
    assert_equal(offline_payment.currency, DEFAULT_PAYMENT_CURRENCY)
    assert_equal(offline_payment.externalId, DEFAULT_PAYMENT_EXTERNAL_ID)

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
      amount: DEFAULT_PAYMENT_AMOUNT,
      currency: DEFAULT_PAYMENT_CURRENCY,
      withholdingAmount: DEFAULT_PAYMENT_WITHHOLDING_AMOUNT,
      withholdingCurrency: DEFAULT_PAYMENT_WITHHOLDING_CURRENCY,
      payoutMethod: DEFAULT_PAYMENT_PAYOUT_METHOD,
      externalId: DEFAULT_PAYMENT_EXTERNAL_ID
    )

    return recipient, offline_payment
  end
end

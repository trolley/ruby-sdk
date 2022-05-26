require_relative 'helper'

class PaymentTest < Test::Unit::TestCase
  DEFAULT_PAYMENT_AMOUNT = "100.00"
  DEFAULT_PAYMENT_CURRENCY = 'USD'

  def setup
    @client = PaymentRails.client(
      ENV.fetch('SANDBOX_API_KEY'),
      ENV.fetch('SANDBOX_SECRET_KEY'),
      ENV.fetch('TROLLEY_ENVIRONMENT'),
      proxy_uri: ENV['PROXY_URI']
    )
  end

  def test_create
    payment = create_payment

    assert_equal payment.amount, DEFAULT_PAYMENT_AMOUNT
    assert_equal payment.currency, DEFAULT_PAYMENT_CURRENCY
  end

  private

  def create_payment
    uuid = SecureRandom.uuid.to_s
    batch = @client.batch.create({})

    recipient = @client.recipient.create(
      firstName: 'John',
      lastName: 'Doe',
      email: "john.doe+#{uuid}@example.com",
      type: 'individual',
      )

    return @client.payment.create(
      batch.id,
      recipient: {
        id: recipient.id,
      },
      amount: DEFAULT_PAYMENT_AMOUNT,
      currency: DEFAULT_PAYMENT_CURRENCY
    )
  end
end
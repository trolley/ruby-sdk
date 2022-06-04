require_relative 'helper'

class PaymentTest < Test::Unit::TestCase
  DEFAULT_PAYMENT_AMOUNT = "100.00"
  DEFAULT_PAYMENT_CURRENCY = 'USD'

  DEFAULT_ACCOUNT_TYPE = 'bank-transfer'
  DEFAULT_ACCOUNT_CURRENCY = 'USD'
  DEFAULT_ACCOUNT_COUNTRY = 'US'
  DEFAULT_ACCOUNT_HOLDER_NAME = 'John Doe'
  DEFAULT_ACCOUNT_NUMBER = '1234567890'
  DEFAULT_ACCOUNT_NUMBER_REDACTED = '********90'
  DEFAULT_ACCOUNT_SWIFT = 'USBKUS44MCT'
  DEFAULT_ACCOUNT_BRANCH_ID = '091000022'

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

  ## NOTE: Can't test this because payment is processing in such a short amount of time
  # def test_update
  #   payment, batch = create_payment
  #
  #   assert_equal payment.amount, DEFAULT_PAYMENT_AMOUNT
  #   assert_equal payment.currency, DEFAULT_PAYMENT_CURRENCY
  #
  #   @client.payment.update(batch.id, payment.id, amount: '200.00')
  #
  #   assert_equal @client.payment.find(batch.id, payment.id).amount, '200.00'
  # end

  private

  def create_payment
    uuid = SecureRandom.uuid.to_s
    batch = @client.batch.create(
      sourceCurrency: 'USD', description: 'Integration Test Payments'
    )

    recipient = @client.recipient.create(
      firstName: 'John',
      lastName: 'Doe',
      email: "john.doe+#{uuid}@example.com",
      type: 'individual',
      address: {
        street1: '123 NYC',
        city: 'NY',
        country: 'US',
        postalCode: '99950'
      }
      )

    @client.recipient_account.create(
      recipient.id,
      {
        type: DEFAULT_ACCOUNT_TYPE,
        currency: DEFAULT_ACCOUNT_CURRENCY,
        country: DEFAULT_ACCOUNT_COUNTRY,
        accountHolderName: DEFAULT_ACCOUNT_HOLDER_NAME,
        accountNumber: DEFAULT_ACCOUNT_NUMBER,
        accountNum: DEFAULT_ACCOUNT_NUMBER,
        swiftBic: DEFAULT_ACCOUNT_SWIFT,
        branchId: DEFAULT_ACCOUNT_BRANCH_ID
      }
    )

    payment = @client.payment.create(
      batch.id,
      recipient: {
        id: recipient.id,
      },
      amount: DEFAULT_PAYMENT_AMOUNT,
      currency: DEFAULT_PAYMENT_CURRENCY
    )

    @client.batch.start_processing(batch.id)

    payment
  end
end

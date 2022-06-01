require_relative 'helper'

class RecipientAccountTest < Test::Unit::TestCase
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
    recipient_account, recipient = create_recipient_account

    assert_equal recipient_account.type, DEFAULT_ACCOUNT_TYPE
    assert_equal recipient_account.currency, DEFAULT_ACCOUNT_CURRENCY
    assert_equal recipient_account.country, DEFAULT_ACCOUNT_COUNTRY
    assert_equal recipient_account.accountHolderName, DEFAULT_ACCOUNT_HOLDER_NAME
    assert_equal recipient_account.accountNum, DEFAULT_ACCOUNT_NUMBER_REDACTED
    assert_equal recipient_account.swiftBic, DEFAULT_ACCOUNT_SWIFT
    assert_equal recipient_account.branchId, DEFAULT_ACCOUNT_BRANCH_ID

    assert_true @client.recipient_account.delete(recipient.id, recipient_account.id)
    assert_true @client.recipient.delete(recipient.id)
  end

  def test_update
    recipient_account, recipient = create_recipient_account

    assert_equal recipient_account.type, DEFAULT_ACCOUNT_TYPE
    assert_equal recipient_account.currency, DEFAULT_ACCOUNT_CURRENCY
    assert_equal recipient_account.country, DEFAULT_ACCOUNT_COUNTRY
    assert_equal recipient_account.accountHolderName, DEFAULT_ACCOUNT_HOLDER_NAME
    assert_equal recipient_account.accountNum, DEFAULT_ACCOUNT_NUMBER_REDACTED
    assert_equal recipient_account.swiftBic, DEFAULT_ACCOUNT_SWIFT
    assert_equal recipient_account.branchId, DEFAULT_ACCOUNT_BRANCH_ID

    recipient_account = @client.recipient_account.update(
      recipient.id,
      recipient_account.id,
      {
        country: 'US',
        accountHolderName: 'Jane Doe',
        accountNumber: '9876543210',
        accountNum: '9876543210'
      }
    )

    assert_equal recipient_account.accountHolderName, 'Jane Doe'
    assert_equal recipient_account.accountNum, '********10'

    assert_true @client.recipient_account.delete(recipient.id, recipient_account.id)
    assert_true @client.recipient.delete(recipient.id)
  end

  def test_delete
    recipient_account, recipient = create_recipient_account

    assert_true @client.recipient_account.delete(recipient.id, recipient_account.id)
    assert_true @client.recipient.delete(recipient.id)
  end

  private

  def create_recipient_account
    uuid = SecureRandom.uuid.to_s
    recipient = @client.recipient.create(
      firstName: 'John',
      lastName: 'Doe',
      email: "john.doe+#{uuid}@example.com",
      type: 'individual'
    )
    recipient_account = @client.recipient_account.create(
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

    return recipient_account, recipient
  end
end

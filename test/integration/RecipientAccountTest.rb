require_relative '../test_helper'

class RecipientAccountTest < Test::Unit::TestCase
  include TestHelper

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/BlockLength
  def test_basic_crud
    with_vcr do
      recipient = @client.recipient.create(
        type: 'individual',
        firstName: 'Tom',
        lastName: 'Jones',
        email: "test.create#{uuid}@example.com"
      )
      recipient_account = @client.recipient_account.create(
        recipient.id, type: 'bank-transfer',
                      currency: 'EUR',
                      country: 'DE',
                      iban: 'DE89 3704 0044 0532 0130 00'
      )

      assert_not_nil(recipient_account)
      assert_equal(recipient_account.type, 'bank-transfer')
      assert_equal(recipient_account.currency, 'EUR')

      recipient_account = @client.recipient_account.update(
        recipient.id, recipient_account.id,
        primary: true
      )

      assert_not_nil(recipient_account)
      assert_equal(recipient_account.type, 'bank-transfer')
      assert_equal(recipient_account.currency, 'EUR')
      assert_equal(recipient_account.primary, true)

      recipient_account = @client.recipient_account.find(
        recipient.id, recipient_account.id
      )

      assert_not_nil(recipient_account)

      response = @client.recipient_account.delete(
        recipient.id, recipient_account.id
      )

      assert_true(response)
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/BlockLength
end

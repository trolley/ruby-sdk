require_relative '../../lib/trolley'
require 'test/unit'
require 'webmock/test_unit'

class GatewayParityTest < Test::Unit::TestCase
  API_BASE = 'http://api.local.dev:3000'.freeze

  def setup
    @gateway = Trolley.client('key', 'secret', api_base: API_BASE)
  end

  def test_balance_aliases_call_documented_endpoints
    stub_request(:get, "#{API_BASE}/v1/balances").to_return(status: 200, body: '{"ok":true}')
    stub_request(:get, "#{API_BASE}/v1/balances/paymentrails").to_return(status: 200, body: '{"ok":true}')
    stub_request(:get, "#{API_BASE}/v1/balances/paypal").to_return(status: 200, body: '{"ok":true}')

    assert_equal true, @gateway.balance.all.ok
    assert_equal true, @gateway.balance.paymentrails.ok
    assert_equal true, @gateway.balance.paypal.ok
  end

  def test_payment_find_by_id_calls_top_level_payment_endpoint
    stub_request(:get, "#{API_BASE}/v1/payments/P-123")
      .to_return(status: 200, body: '{"payment":{"id":"P-123"}}')

    payment = @gateway.payment.find_by_id('P-123')

    assert_equal 'P-123', payment.id
  end

  def test_verification_gateway_calls_documented_trust_endpoints
    stub_request(:get, "#{API_BASE}/v1/verifications?verificationType=watchlist&page=1&pageSize=10")
      .to_return(status: 200, body: verification_response)
    stub_request(:patch, "#{API_BASE}/v1/verifications/expire")
      .with(body: '{"type":"individual","verificationIds":["IV-123"]}')
      .to_return(status: 200, body: verification_response)
    stub_request(:post, "#{API_BASE}/v1/verifications/watchlist/trigger")
      .with(body: '{"recipientIds":["R-123"]}')
      .to_return(status: 200, body: verification_response)
    stub_request(:post, "#{API_BASE}/v1/verifications/individual/trigger")
      .with(body: '{"recipientIds":["R-123"]}')
      .to_return(status: 200, body: verification_response)

    assert_equal 'WV-123', @gateway.verification.search(verificationType: 'watchlist', page: 1, pageSize: 10).verifications.first.id
    assert_equal 'WV-123', @gateway.verification.expire(type: 'individual', verificationIds: ['IV-123']).verifications.first.id
    assert_equal 'WV-123', @gateway.verification.trigger_watchlist(recipientIds: ['R-123']).verifications.first.id
    assert_equal 'WV-123', @gateway.trust.trigger('individual', recipientIds: ['R-123']).verifications.first.id
  end

  def test_existing_deletes_support_single_and_multiple_ids
    stub_request(:delete, "#{API_BASE}/v1/batches/B-123").to_return(status: 200, body: '{"ok":true}')
    stub_request(:delete, "#{API_BASE}/v1/batches/")
      .with(body: '{"ids":["B-123","B-456"]}')
      .to_return(status: 200, body: '{"ok":true}')
    stub_request(:delete, "#{API_BASE}/v1/recipients/R-123").to_return(status: 200, body: '{"ok":true}')
    stub_request(:delete, "#{API_BASE}/v1/recipients/")
      .with(body: '{"ids":["R-123","R-456"]}')
      .to_return(status: 200, body: '{"ok":true}')

    assert_equal true, @gateway.batch.delete('B-123')
    assert_equal true, @gateway.batch.delete(%w[B-123 B-456])
    assert_equal true, @gateway.recipient.delete('R-123')
    assert_equal true, @gateway.recipient.delete(%w[R-123 R-456])
  end

  def test_documented_body_fields_pass_through
    recipient_body = {
      referenceId: 'ref-123',
      type: 'individual',
      firstName: 'Ada',
      governmentIds: [{ type: 'ssn', value: '1234' }],
      tags: ['new']
    }
    stub_request(:post, "#{API_BASE}/v1/recipients/")
      .with(body: recipient_body.to_json)
      .to_return(status: 200, body: '{"recipient":{"id":"R-123"}}')

    payment_body = {
      recipient: { id: 'R-123' },
      amount: '10.00',
      currency: 'USD',
      tags: ['docs'],
      forceUsTaxActivity: true
    }
    stub_request(:post, "#{API_BASE}/v1/batches/B-123/payments")
      .with(body: payment_body.to_json)
      .to_return(status: 200, body: '{"payment":{"id":"P-123"}}')

    assert_equal 'R-123', @gateway.recipient.create(recipient_body).id
    assert_equal 'P-123', @gateway.payment.create('B-123', payment_body).id
  end

  def test_invoice_payment_response_fields_are_mapped
    stub_request(:post, "#{API_BASE}/v1/invoices/payment/search")
      .with(body: '{"invoiceIds":["I-123"]}')
      .to_return(status: 200, body: invoice_payment_search_response)

    invoice_payment = @gateway.invoice_payment.search(invoiceIds: ['I-123']).first

    assert_equal 'pending', invoice_payment.status
    assert_equal 'payment memo', invoice_payment.memo
    assert_equal 'payment-external-id_123', invoice_payment.externalId
    assert_equal ['invoice_payment', 'royalty invoice'], invoice_payment.tags
    assert_equal true, invoice_payment.coverFees
  end

  def test_gateway_exposes_verification_and_trust_aliases
    assert_same @gateway.verification, @gateway.trust
  end

  private

  def verification_response
    '{"ok":true,"verifications":[{"id":"WV-123","type":"watchlist"}],"meta":{"page":1,"pages":1,"records":1}}'
  end

  def invoice_payment_search_response
    '{"ok":true,"invoicePayments":[{"invoiceId":"I-123","invoiceLineId":"IL-123","paymentId":"P-123","amount":{"value":"150.00","currency":"EUR"},"status":"pending","memo":"payment memo","externalId":"payment-external-id_123","tags":["invoice_payment","royalty invoice"],"coverFees":true}]}'
  end
end

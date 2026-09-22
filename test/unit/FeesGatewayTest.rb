require_relative '../../lib/trolley'
require 'test/unit'
require 'webmock/test_unit'

class FeesGatewayTest < Test::Unit::TestCase
  API_BASE = 'http://api.local.dev:3000'.freeze

  def setup
    @fees = Trolley.client('key', 'secret', api_base: API_BASE).fees
  end

  def test_search_route_pricing_returns_fee_and_revenue_stream_models
    stub_request(:post, "#{API_BASE}/v1/fees/route-pricing/search")
      .with(body: '{"currency":"USD"}')
      .to_return(status: 200, body: route_pricing_response)

    fees = @fees.search_route_pricing(currency: 'USD')
    revenue_stream = fees.first.revenueStream['bankTransfer']['ach']

    assert_equal Trolley::Fee, fees.first.class
    assert_equal 'USD', fees.first.currencyCode
    assert_equal Trolley::RevenueStream, revenue_stream.class
    assert_equal 'RSRC-123', revenue_stream.revenueShareId
    assert_nil revenue_stream.percentCap['max']
  end

  def test_create_revenue_stream_returns_revenue_stream_model
    request = revenue_stream_request
    stub_request(:post, "#{API_BASE}/v1/fees/revenue-stream/create")
      .with(body: request.to_json)
      .to_return(status: 200, body: revenue_stream_response)

    revenue_stream = @fees.create_revenue_stream(request)

    assert_equal Trolley::RevenueStream, revenue_stream.class
    assert_equal '8.00', revenue_stream.merchantAmount
  end

  def test_update_revenue_stream_preserves_explicit_null_cap
    request = revenue_stream_request.merge(
      revenueShareId: 'RSRC-123',
      minPercentCapAmount: nil
    )
    stub_request(:post, "#{API_BASE}/v1/fees/revenue-stream/update")
      .with(body: request.to_json)
      .to_return(status: 200, body: revenue_stream_response)

    revenue_stream = @fees.update_revenue_stream(request)

    assert_equal 'RSRC-123', revenue_stream.revenueShareId
    assert_requested :post, "#{API_BASE}/v1/fees/revenue-stream/update",
                     body: /"minPercentCapAmount":null/
    assert_not_requested :post, "#{API_BASE}/v1/fees/revenue-stream/update",
                         body: /maxPercentCapAmount/
  end

  private

  def revenue_stream_request
    {
      currencyCode: 'USD',
      integration: 'bank-transfer',
      routeType: 'ach',
      merchantAmountType: 'percentage',
      merchantAmount: '8.00'
    }
  end

  def route_pricing_response
    <<~JSON
      {
        "ok": true,
        "fees": [{
          "currencyCode": "USD",
          "revenueStream": {
            "bankTransfer": {
              "ach": {
                "currencyCode": "USD",
                "integration": "bank-transfer",
                "routeType": "ach",
                "merchantAmountType": "percentage",
                "merchantAmount": "8.00",
                "percentCap": {"min": "2.00", "max": null},
                "revenueShareId": "RSRC-123"
              }
            }
          }
        }]
      }
    JSON
  end

  def revenue_stream_response
    <<~JSON
      {
        "ok": true,
        "revenueStream": {
          "currencyCode": "USD",
          "integration": "bank-transfer",
          "routeType": "ach",
          "merchantAmountType": "percentage",
          "merchantAmount": "8.00",
          "percentCap": {"min": null, "max": null},
          "revenueShareId": "RSRC-123"
        }
      }
    JSON
  end
end

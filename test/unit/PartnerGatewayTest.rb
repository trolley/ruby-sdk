require_relative '../../lib/trolley'
require 'test/unit'
require 'webmock/test_unit'

class PartnerGatewayTest < Test::Unit::TestCase
  API_BASE = 'http://api.local.dev:3000'.freeze

  def setup
    @partner = Trolley.client('key', 'secret', api_base: API_BASE).partner
    @body = { enabled: true }
  end

  def test_read_methods_call_documented_endpoints
    %w[
      /v1/fees
      /v1/payout-methods
      /v1/payout-methods/bank-transfer
      /v1/processing-settings
      /v1/white-label/dns-records
      /v1/white-label
      /v1/iframe/config
    ].each do |path|
      stub_request(:get, "#{API_BASE}#{path}").to_return(status: 200, body: '{"ok":true}')
    end
    stub_request(:get, "#{API_BASE}/v1/fees?currency=USD")
      .to_return(status: 200, body: '{"ok":true}')

    assert_equal true, @partner.get_fees.ok
    assert_equal true, @partner.get_fees('USD').ok
    assert_equal true, @partner.list_payout_methods.ok
    assert_equal true, @partner.get_payout_method('bank-transfer').ok
    assert_equal true, @partner.get_processing_settings.ok
    assert_equal true, @partner.get_white_label_dns_records.ok
    assert_equal true, @partner.get_white_label_settings.ok
    assert_equal true, @partner.get_widget_configuration.ok
  end

  def test_mutation_methods_call_documented_endpoints
    patch_paths = %w[
      /v1/fees
      /v1/payout-methods/bank-transfer
      /v1/processing-settings
      /v1/white-label/icon
      /v1/white-label
    ]
    patch_paths.each do |path|
      stub_request(:patch, "#{API_BASE}#{path}")
        .with(body: @body.to_json)
        .to_return(status: 200, body: '{"ok":true}')
    end
    stub_request(:post, "#{API_BASE}/v1/white-label/dns-records/verify")
      .with(body: '{}')
      .to_return(status: 200, body: '{"ok":true}')
    stub_request(:post, "#{API_BASE}/v1/iframe/config")
      .with(body: @body.to_json)
      .to_return(status: 200, body: '{"ok":true}')
    stub_request(:delete, "#{API_BASE}/v1/white-label/email")
      .to_return(status: 200, body: '{"ok":true}')

    assert_equal true, @partner.update_fees(@body).ok
    assert_equal true, @partner.update_payout_method('bank-transfer', @body).ok
    assert_equal true, @partner.update_processing_settings(@body).ok
    assert_equal true, @partner.verify_white_label_dns_records.ok
    assert_equal true, @partner.delete_white_label_email.ok
    assert_equal true, @partner.update_white_label_icon(@body).ok
    assert_equal true, @partner.update_white_label_settings(@body).ok
    assert_equal true, @partner.update_widget_configuration(@body).ok
  end
end

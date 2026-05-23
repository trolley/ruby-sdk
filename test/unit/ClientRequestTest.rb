require_relative '../../lib/trolley'
require 'test/unit'
require 'webmock/test_unit'

class ClientRequestTest < Test::Unit::TestCase
  def setup
    @config = Trolley::Configuration.new('key', 'secret', api_base: 'http://api.local.dev:3000')
    @client = Trolley::Client.new(@config)
  end

  def test_request_posts_json_body_with_signed_headers
    stub_request(:post, 'http://api.local.dev:3000/v1/recipients')
      .with(
        body: '{"type":"individual"}',
        headers: {
          'Authorization' => /^prsign key:/,
          'Content-Type' => 'application/json',
          'Trolley-Source' => "ruby-sdk_#{Trolley::VERSION}"
        }
      )
      .to_return(status: 201, body: '{"ok":true}')

    response = @client.request('POST', '/v1/recipients', type: 'individual')

    assert_equal '{"ok":true}', response
    assert_requested :post, 'http://api.local.dev:3000/v1/recipients'
  end

  def test_request_delete_supports_json_body
    stub_request(:delete, 'http://api.local.dev:3000/v1/recipients')
      .with(body: '{"ids":["R-123"]}')
      .to_return(status: 200, body: '{"ok":true}')

    @client.request('DELETE', '/v1/recipients', ids: ['R-123'])

    assert_requested :delete, 'http://api.local.dev:3000/v1/recipients'
  end

  def test_request_accepts_204_response
    stub_request(:delete, 'http://api.local.dev:3000/v1/recipients/R-123')
      .to_return(status: 204, body: '')

    assert_nil @client.request('DELETE', '/v1/recipients/R-123')
  end

  def test_gateway_exposes_request_without_changing_existing_accessors
    gateway = Trolley.client('key', 'secret', api_base: 'http://api.local.dev:3000')

    assert_respond_to gateway, :request
    assert_respond_to gateway, :recipient
    assert_respond_to gateway, :batch
    assert_respond_to gateway, :invoice
  end
end

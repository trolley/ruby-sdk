require_relative '../../lib/trolley'
require 'test/unit'

class TrolleyTest < Test::Unit::TestCase
  def test_client
    Trolley.client('key', 'secret', proxy_uri: 'http://user:pass@gimmeproxy.com:80')
  end

  def test_client_invalid_proxy_uri
    proxy_uri = 'not_://*a_valid_proxy'
    assert_raise Trolley::Configuration::InvalidProxyAddress.new("Invalid proxy provided to configuration: #{proxy_uri}") do
      Trolley.client('k', 's', proxy_uri: proxy_uri)
    end
  end
end

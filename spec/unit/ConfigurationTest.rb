require_relative '../../lib/trolley'
require 'test/unit'

class ConfigurationTest < Test::Unit::TestCase
  def test_new_nil
    assert_raise ArgumentError.new('Both key/secret must be a nonempty string') do
      Trolley::Configuration.new(nil, nil)
    end
  end

  def test_new_empty_string
    assert_raise ArgumentError.new('Both key/secret must be a nonempty string') do
      Trolley::Configuration.new('', '')
    end
  end

  def test_new_nonempty_string
    assert_nothing_raised do
      Trolley::Configuration.new('key', 'secret')
    end
  end

  def test_api_base
    assert_equal 'https://api.trolley.com', Trolley::Configuration.new('key', 'secret').api_base
    assert_equal 'https://api.railz.io', Trolley::Configuration.new('key', 'secret', api_base: 'https://api.railz.io').api_base
  end

  def test_use_ssl?
    assert_equal false, Trolley::Configuration.new('key', 'secret', api_base: 'http://example.com').useSsl?
    assert_equal true, Trolley::Configuration.new('key', 'secret').useSsl?
  end

  def test_invalid_proxy_uri
    proxy_uri = 'not_://*a_valid_proxy'
    assert_raise Trolley::Configuration::InvalidProxyAddress.new("Invalid proxy provided to configuration: #{proxy_uri}") do
      Trolley::Configuration.new('k', 's', proxy_uri: proxy_uri).proxy
    end
  end

  def test_vaid_proxy_uri
    config = Trolley::Configuration.new('k', 's', proxy_uri: 'http://user:pass@gimmeproxy.com:80')
    assert_equal 'gimmeproxy.com', config.proxy.host
    assert_equal 80, config.proxy.port
    assert_equal 'user', config.proxy.user
    assert_equal 'pass', config.proxy.password
  end
end

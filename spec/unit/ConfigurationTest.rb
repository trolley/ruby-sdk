require_relative '../../lib/trolley'
require 'test/unit'

class ConfigurationTest < Test::Unit::TestCase
  def test_new_nil
    assert_raise ArgumentError.new('Both key/secret must be a nonempty string') do
      PaymentRails::Configuration.new(nil, nil)
    end
  end

  def test_new_empty_string
    assert_raise ArgumentError.new('Both key/secret must be a nonempty string') do
      PaymentRails::Configuration.new('', '')
    end
  end

  def test_new_nonempty_string
    assert_nothing_raised do
      PaymentRails::Configuration.new('key', 'secret')
    end
  end

  def test_api_base
    assert_equal 'http://api.local.dev:3000', PaymentRails::Configuration.new('key', 'secret', 'integration').apiBase
    assert_equal 'https://api.trolley.com', PaymentRails::Configuration.new('key', 'secret', 'production').apiBase
    assert_equal 'https://api.railz.io', PaymentRails::Configuration.new('key', 'secret', 'development').apiBase
    assert_equal 'https://api.trolley.com', PaymentRails::Configuration.new('key', 'secret', 'non_standard_environment').apiBase
  end

  def test_use_ssl?
    assert_equal false, PaymentRails::Configuration.new('key', 'secret', 'integration').useSsl?
    assert_equal true, PaymentRails::Configuration.new('key', 'secret', 'production').useSsl?
    assert_equal true, PaymentRails::Configuration.new('key', 'secret', 'development').useSsl?
    assert_equal true, PaymentRails::Configuration.new('key', 'secret', 'non_standard_environment').useSsl?
  end

  def test_invalid_proxy_uri
    proxy_uri = 'not_://*a_valid_proxy'
    assert_raise PaymentRails::Configuration::InvalidProxyAddress.new("Invalid proxy provided to configuration: #{proxy_uri}") do
      PaymentRails::Configuration.new('k', 's', 'production', proxy_uri: proxy_uri).proxy
    end
  end

  def test_vaid_proxy_uri
    config = PaymentRails::Configuration.new('k', 's', 'production', proxy_uri: 'http://user:pass@gimmeproxy.com:80')
    assert_equal 'gimmeproxy.com', config.proxy.host
    assert_equal 80, config.proxy.port
    assert_equal 'user', config.proxy.user
    assert_equal 'pass', config.proxy.password
  end
end

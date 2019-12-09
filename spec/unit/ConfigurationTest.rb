require_relative '../../lib/paymentrails'
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
    assert_equal 'https://api.paymentrails.com', PaymentRails::Configuration.new('key', 'secret', 'production').apiBase
    assert_equal 'https://api.railz.io', PaymentRails::Configuration.new('key', 'secret', 'development').apiBase
    assert_equal 'https://api.paymentrails.com', PaymentRails::Configuration.new('key', 'secret', 'non_standard_environment').apiBase
  end

  def test_use_ssl?
    assert_equal false, PaymentRails::Configuration.new('key', 'secret', 'integration').useSsl?
    assert_equal true, PaymentRails::Configuration.new('key', 'secret', 'production').useSsl?
    assert_equal true, PaymentRails::Configuration.new('key', 'secret', 'development').useSsl?
    assert_equal true, PaymentRails::Configuration.new('key', 'secret', 'non_standard_environment').useSsl?
  end
end

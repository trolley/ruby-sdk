module Trolley
  class Configuration
    class InvalidProxyAddress < StandardError; end
    attr_reader :api_base, :proxy, :environment

    DEFAULT_API_BASE = 'https://api.trolley.com'.freeze

    def initialize(publicKey, privateKey, **optionals)
      raise ArgumentError, 'Both key/secret must be a nonempty string' if publicKey.to_s&.empty? || privateKey.to_s&.empty?

      @publicKey = publicKey
      @privateKey = privateKey
      @api_base = optionals[:api_base] || DEFAULT_API_BASE
      # failfast on a bad proxy
      proxy_uri = optionals[:proxy_uri]
      begin
        @proxy = proxy_uri.nil? ? nil : URI.parse(proxy_uri)
      rescue URI::InvalidURIError
        raise InvalidProxyAddress, "Invalid proxy provided to configuration: #{proxy_uri}"
      end
    end

    def useSsl?
      api_base.start_with? 'https'
    end

    attr_accessor :publicKey, :privateKey

  end
end

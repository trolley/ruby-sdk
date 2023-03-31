module PaymentRails
  class Configuration
    class InvalidProxyAddress < StandardError; end

    def initialize(publicKey, privateKey, environment = 'production', proxy_uri: nil)
      raise ArgumentError, 'Both key/secret must be a nonempty string' if publicKey.to_s&.empty? || privateKey.to_s&.empty?

      @publicKey = publicKey
      @privateKey = privateKey
      @environment = environment
      # failfast on a bad proxy
      begin
        @proxy = proxy_uri.nil? ? nil : URI.parse(proxy_uri)
      rescue URI::InvalidURIError
        raise InvalidProxyAddress, "Invalid proxy provided to configuration: #{proxy_uri}"
      end
    end

    def apiBase
      case environment
      when 'production'
        'https://api.trolley.com'
      when 'development'
        'https://api.railz.io'
      when 'integration'
        'http://api.local.dev:3000'
      else
        'https://api.trolley.com'
      end
    end

    def useSsl?
      apiBase.start_with? 'https'
    end

    attr_reader :proxy

    attr_reader :publicKey

    attr_writer :publicKey

    attr_reader :privateKey

    attr_writer :privateKey

    attr_reader :environment
  end
end

module PaymentRails
  class Configuration

    def initialize(publicKey, privateKey, environment = 'production')
      if publicKey&.empty? || privateKey&.empty?
        raise ArgumentError, 'Both key/secret must be a nonempty string'
      end

      @publicKey = publicKey
      @privateKey = privateKey
      @environment = environment
    end

    def apiBase
      case environment
      when 'production'
        'https://api.paymentrails.com'
      when 'development'
        'https://api.railz.io'
      when 'integration'
        'http://api.local.dev:3000'
      else
        'https://api.paymentrails.com'
      end
    end

    def useSsl?
      apiBase.start_with? 'https'
    end

    attr_reader :publicKey

    attr_writer :publicKey

    attr_reader :privateKey

    attr_writer :privateKey

    attr_reader :environment
  end
end
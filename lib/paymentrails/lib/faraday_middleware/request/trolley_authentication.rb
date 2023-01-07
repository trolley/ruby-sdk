# frozen_string_literal: true

require 'digest'
require 'openssl'

module FaradayMiddleware
  class TrolleyAuthentication < ::Faraday::Middleware
    def initialize(app)
      @time = Time.now.to_i.to_s
      super(app)
    end

    def call(env)
      env[:request_headers]['X-PR-Timestamp'] = @time
      env[:request_headers]['Authorization'] = authentication_header(env)
      @app.call(env)
    end

    private

    def authentication_header(env)
      api_key_token = env.dig(:request, :context, :api_key_token)
      "prsign #{api_key_token}:#{authorization_signature(env)}"
    end

    def authorization_signature(env)
      endpoint = env.dig(:request, :context, :endpoint)
      api_key_secret = env.dig(:request, :context, :api_key_secret)

      message = [@time, env[:method].upcase, endpoint, env[:body]].join("\n") + "\n"
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), api_key_secret, message)
    end
  end
end
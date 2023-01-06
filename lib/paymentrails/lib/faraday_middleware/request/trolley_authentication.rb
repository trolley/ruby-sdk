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
      env[:request_headers]['Authorization'] = authorization_header(env)
      @app.call(env)
    end

    private

    def authorization_header(env)
      "prsign #{env[:api_key_token]}:#{authorization_signature(env)}"
    end

    def authorization_signature(env)
      message = [@time, env[:method], env[:endpoint], env[:body]].join("\n") + "\n"
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), env[:api_key_secret], message)
    end
  end
end
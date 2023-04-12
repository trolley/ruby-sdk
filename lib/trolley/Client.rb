# require_relative 'Exceptions.rb'
require 'digest'
require 'net/http'
require 'openssl'
require 'uri'
require 'json'
require "rubygems"

module Trolley
  class Client
    def initialize(config)
      @config = config
    end

    def get(endPoint)
      send_request(endPoint, 'GET')
    end

    def post(endPoint, body)
      body = body.to_json
      send_request(endPoint, 'POST', body)
    end

    def delete(endPoint, body = '')
      body = body.to_json if body != ''
      send_request(endPoint, 'DELETE', body)
    end

    def patch(endPoint, body)
      body = body.to_json
      send_request(endPoint, 'PATCH', body)
    end

    private

    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/PerceivedComplexity
    def send_request(endPoint, method, body = '')
      uri = URI.parse(@config.apiBase + endPoint)
      http = Net::HTTP.new(
        uri.host, uri.port,
        @config.proxy&.host, @config.proxy&.port, @config.proxy&.user, @config.proxy&.password
      )
      http.use_ssl = @config.useSsl?

      time = Time.now.to_i
      headers = {'X-PR-Timestamp': time.to_s,
                'Authorization': generate_authorization(time, endPoint, method, body),
                'Content-Type': 'application/json',
                'Trolley-Source': "ruby-sdk_#{::Trolley::VERSION}"}

      if method === "GET"
        request = Net::HTTP::Get.new(uri.request_uri, headers)
      elsif method === "POST"
        request = Net::HTTP::Post.new(uri.request_uri, headers)
        request.body = body
      elsif method === "PATCH"
        request = Net::HTTP::Patch.new(uri.request_uri, headers)
        request.body = body
      elsif method === "DELETE"
        request = Net::HTTP::Delete.new(uri.request_uri, headers)
        request.body = body
      end

      response = http.request(request)

      if response.code != '200' && response.code != '204'
        throw_status_code_exception("#{response.message} #{response.body}" , response.code, response.body)
      end
      response.body
    end
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/PerceivedComplexity

    private
    def generate_authorization(time, endPoint, method, body)
      message = "#{[time.to_s, method, endPoint, body].join("\n")}\n"
      signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @config.privateKey, message)
      "prsign #{@config.publicKey}:#{signature}"
    end

    private

    # rubocop:disable Metrics/CyclomaticComplexity
    def throw_status_code_exception(message, code, body = nil)
      validation_errors = []
      unless body.nil?
        begin
          body = JSON.parse(body)
          validation_errors = body['errors']
        rescue JSON::ParserError
          # no-op
        end
      end

      case code
      when '400'
        raise MalformedRequestError.new(message, validation_errors)
      when '401'
        raise AuthenticationError.new(message, validation_errors)
      when '403'
        raise AuthorizationError.new(message, validation_errors)
      when '404'
        raise NotFoundError.new(message, validation_errors)
      when '429'
        raise TooManyRequestsError.new(message, validation_errors)
      when '500'
        raise ServerError.new(message, validation_errors)
      when '503'
        raise DownForMaintenanceError.new(message, validation_errors)
      else
        raise UnexpectedError.new(message, validation_errors)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity
  end
end

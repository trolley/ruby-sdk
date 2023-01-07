# require_relative 'Exceptions.rb'
require 'net/http'
require 'uri'
require 'json'

require 'faraday'
require_relative 'lib/faraday_middleware/trolley_authentication.rb'

module PaymentRails
  class Client
    def initialize(config)
      @config = config
    end

    def get(endPoint)
      response = conn.get(@config.apiBase + endPoint) do |req|
        req.options.context = req.options.context.merge(endpoint: endPoint)
      end

      p response.body
    end

    def conn
      Faraday.new(default_endpoint, default_request_context) do |f|
        f.request :url_encoded
        f.request :trolley_authentication
        f.adapter Faraday.default_adapter
      end
    end

    def default_endpoint
      nil
    end
    def default_request_context
      {
        request: {
          context: {
            api_key_token: @config.publicKey,
            api_key_secret: @config.privateKey
          }
        }
      }
    end

    def post(endPoint, body)
      body = body.to_json
      send_request(endPoint, 'POST', body)
    end

    def delete(endPoint)
      send_request(endPoint, 'DELETE')
    end

    def patch(endPoint, body)
      body = body.to_json
      send_request(endPoint, 'PATCH', body)
    end

    private

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
                'Content-Type': 'application/json'}

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
      end

      response = http.request(request)

      if response.code != '200' && response.code != '204'
        throw_status_code_exception(response.message + ' ' + response.body , response.code)
      end
      response.body
    end

    private
    def generate_authorization(time, endPoint, method, body)
      message = [time.to_s, method, endPoint, body].join("\n") + "\n"
      signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @config.privateKey, message)
      'prsign ' + @config.publicKey + ':' + signature
    end

    private
    def throw_status_code_exception(message, code)
        case code
        when '400'
          raise MalformedException, message
        when '401'
          raise AuthenticationError, message
        when '403'
          raise AuthorizationError, message
        when '404'
          raise NotFoundError, message
        when '429'
          raise TooManyRequestsError, message
        when '500'
          raise ServerError, message
        when '503'
          raise DownForMaintenanceError, message
        else
          raise UnexpectedError, message
        end
    end
  end
end

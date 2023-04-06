require_relative '../../lib/trolley'
require 'dotenv/load'
require 'test/unit'
require 'securerandom'

module ApiClientHelper
  def setup
    @client = Trolley.client(
      ENV.fetch('SANDBOX_API_KEY'),
      ENV.fetch('SANDBOX_SECRET_KEY'),
      api_base: ENV['API_BASE'],
      proxy_uri: ENV['PROXY_URI']
    )
  end
end

def uuid
  SecureRandom.uuid.to_s
end

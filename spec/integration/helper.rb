require_relative '../../lib/trolley'
require 'dotenv/load'
require 'test/unit'
require 'securerandom'

module ApiClientHelper
  def setup
    @client = Trolley.client(
      ENV.fetch('SANDBOX_API_KEY'),
      ENV.fetch('SANDBOX_SECRET_KEY'),
      'production',
      proxy_uri: ENV['PROXY_URI']
    )
  end
end

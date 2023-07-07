require_relative '../lib/trolley'
require 'dotenv/load'
require 'test/unit'
require 'securerandom'
require 'webmock/test_unit'
require 'vcr'

module TestHelper
  def setup
    @fixture_test_path = "test/fixtures/#{self.class.name.split('::').last}"
    @test_case = method_name.chomp('_')

    @client = Trolley.client(
      ENV.fetch('SANDBOX_API_KEY'),
      ENV.fetch('SANDBOX_SECRET_KEY'),
      api_base: ENV['API_BASE'],
      proxy_uri: ENV['PROXY_URI']
    )

    VCR.configure do |config|
      config.cassette_library_dir = @fixture_test_path
      config.hook_into :webmock

      config.before_record do |interaction|
        interaction.request.headers.delete('Authorization')
        interaction.request.headers.delete('Trolley-Source')
      end
    end
  end

  def uuid
    SecureRandom.uuid.to_s
  end

  def with_vcr(&block)
    VCR.use_cassette(@test_case, &block)
  end
end

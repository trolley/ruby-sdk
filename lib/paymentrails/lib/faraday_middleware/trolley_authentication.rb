# frozen_string_literal: true

require 'faraday'

module FaradayMiddleware
  autoload :TrolleyAuthentication, "#{File.dirname(__FILE__)}/request/trolley_authentication"

  Faraday::Request.register_middleware trolley_authentication: -> { TrolleyAuthentication }
end
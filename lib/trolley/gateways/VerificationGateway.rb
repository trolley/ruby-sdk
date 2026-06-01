require_relative '../Client'
require 'json'
require 'ostruct'
require 'uri'

module Trolley
  class VerificationGateway
    def initialize(client)
      @client = client
    end

    def search(filters = {})
      path = '/v1/verifications'
      query_string = URI.encode_www_form(filters)
      path = "#{path}?#{query_string}" unless query_string.empty?

      verification_list_builder(@client.get(path))
    end

    alias all search

    def expire(body)
      verification_list_builder(@client.patch('/v1/verifications/expire', body))
    end

    def trigger(verification_type, body)
      verification_list_builder(@client.post("/v1/verifications/#{verification_type}/trigger", body))
    end

    def trigger_watchlist(body)
      trigger('watchlist', body)
    end

    private

    def verification_list_builder(response)
      JSON.parse(response, object_class: OpenStruct)
    end
  end
end

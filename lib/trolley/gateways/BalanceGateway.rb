require_relative '../Client'
require 'ostruct'

module Trolley
  class BalanceGateway
    def initialize(client)
      @client = client
    end

    def find(term = '')
      path = term.to_s.empty? ? '/v1/balances/' : "/v1/balances/#{term}"
      response = @client.get(path)
      JSON.parse(response,  object_class: OpenStruct)
    end

    def all
      balance_builder(@client.get('/v1/balances'))
    end

    def paymentrails
      balance_builder(@client.get('/v1/balances/paymentrails'))
    end

    def paypal
      balance_builder(@client.get('/v1/balances/paypal'))
    end

    def balance_builder(response)
      JSON.parse(response, object_class: OpenStruct)
    end
  end
end

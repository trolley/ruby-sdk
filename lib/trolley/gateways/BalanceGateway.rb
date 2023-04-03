require_relative '../Client.rb'

module Trolley
  class BalanceGateway
    def initialize(client)
      @client = client
    end

    def find(term = '')
      response = @client.get('/v1/balances/' + term )
      JSON.parse(response,  object_class: OpenStruct)
    end

  end
end

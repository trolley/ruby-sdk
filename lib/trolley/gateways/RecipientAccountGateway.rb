require_relative '../Client'
require_relative 'GatewayHelper'

module Trolley
  class RecipientAccountGateway
    def initialize(client)
      @client = client
    end

    def find(recipient_id, recipient_account_id)
      response = @client.get("/v1/recipients/#{recipient_id}/accounts/#{recipient_account_id}")
      recipient_account_builder(response)
    end

    def all(recipient_id)
      response = @client.get("/v1/recipients/#{recipient_id}/accounts/")
      recipient_account_list_builder(response)
    end

    def create(recipient_id, body)
      response = @client.post("/v1/recipients/#{recipient_id}/accounts", body)
      recipient_account_builder(response)
    end

    def update(recipient_id, recipient_account_id, body)
      response = @client.patch("/v1/recipients/#{recipient_id}/accounts/#{recipient_account_id}", body)
      recipient_account_builder(response)
    end

    def delete(recipient_id, recipient_account_id)
      @client.delete("/v1/recipients/#{recipient_id}/accounts/#{recipient_account_id}")
      true
    end

    def recipient_account_builder(response)
      Utils::ResponseMapper.build(response, RecipientAccount)
    end

    def recipient_account_list_builder(response)
      Utils::PaginatedArray.from_response(response, RecipientAccount)
    end
  end
end

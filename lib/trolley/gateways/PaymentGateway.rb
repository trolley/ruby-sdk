require_relative '../Client'
require_relative 'GatewayHelper'

module Trolley
  class PaymentGateway
    def initialize(client)
      @client = client
    end

    def find(batch_id, payment_id)
      response = @client.get("/v1/batches/#{batch_id}/payments/#{payment_id}")
      payment_builder(response)
    end

    def create(batch_id, body)
      response = @client.post("/v1/batches/#{batch_id}/payments", body)
      payment_builder(response)
    end

    def update(batch_id, payment_id, body)
      @client.patch("/v1/batches/#{batch_id}/payments/#{payment_id}", body)
      true
    end

    def delete(batch_id, payment_id)
      @client.delete("/v1/batches/#{batch_id}/payments/#{payment_id}")
      true
    end

    def search(batch_id, page = 1, page_size = 10, term = '')
      response = @client.get("/v1/batches/#{batch_id}/payments?page=#{page}&pageSize=#{page_size}&search=#{term}")
      payments_list_builder(response)
    end

    def payment_builder(response)
      Utils::ResponseMapper.build(response, Payment)
    end

    def payments_list_builder(response)
      Utils::PaginatedArray.from_response(response, Payment)
    end
  end
end

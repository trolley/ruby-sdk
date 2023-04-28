require_relative '../Client'

module Trolley
  class OfflinePaymentGateway
    def initialize(client)
      @client = client
    end

    def create(recipient_id, body)
      response = @client.post("/v1/recipients/#{recipient_id}/offlinePayments", body)
      offline_payment_builder(response)
    end

    def update(recipient_id, offline_payment_id, body)
      @client.patch("/v1/recipients/#{recipient_id}/offlinePayments/#{offline_payment_id}", body)
      true
    end

    def delete(recipient_id, offline_payment_id)
      @client.delete("/v1/recipients/#{recipient_id}/offlinePayments/#{offline_payment_id}")
      true
    end

    # rubocop:disable Metrics/ParameterLists
    def search(recipient_id = '', page = 1, page_size = 10, term = '')
      if recipient_id === ''
        response = @client.get("/v1/offline-payments?page=#{page}&pageSize=#{page_size}&search=#{term}")
      else
        response = @client.get("/v1/recipients/#{recipient_id}/offlinePayments?page=#{page}&pageSize=#{page_size}&search=#{term}")
      end

      offline_payments_list_builder(response)
    end
    # rubocop:enable Metrics/ParameterLists

    def offline_payment_builder(response)
      Utils::ResponseMapper.build(response, OfflinePayment)
    end

    def offline_payments_list_builder(response)
      Utils::PaginatedArray.from_response(response, OfflinePayment)
    end
  end
end

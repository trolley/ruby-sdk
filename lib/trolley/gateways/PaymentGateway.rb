require_relative '../Client'
require_relative 'GatewayHelper'

module Trolley
  class PaymentGateway
    include GatewayHelper

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
      payment = Payment.new
      data = JSON.parse(response)
      data.each do |key, value|
        next unless key === 'payment'
        loosely_hydrate_model(payment, value)
      end
      payment
    end

    def payments_list_builder(response)
      payments = []
      data = JSON.parse(response)

      data.each do |key, value|
        next unless key === 'payments'
        value.each do |newKey, _newValue|
          payment = loosely_hydrate_model(Payment.new, newKey)
          payments.push(payment)
        end
      end
      payments
    end
  end
end

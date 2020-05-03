require_relative '../Client.rb'
require_relative 'GatewayHelper'

module PaymentRails
  class OfflinePaymentGateway
    include GatewayHelper

    def initialize(client)
      @client = client
    end

    def create(recipient_id, body)
      response = @client.post('/v1/recipients/' + recipient_id + '/offlinePayments', body)
      offline_payment_builder(response)
    end

    def update(recipient_id, offline_payment_id, body)
      @client.patch('/v1/recipients/' + recipient_id + '/offlinePayments/' + offline_payment_id, body)
      true
    end

    def delete(recipient_id, offline_payment_id)
      @client.delete('/v1/recipients/' + recipient_id + '/offlinePayments/' + offline_payment_id)
      true
    end

    def search(recipient_id = '', page = 1, page_size = 10, term = '')
      if recipient_id === ''
        response = @client.get('/v1/offline-payments?page=' + page.to_s + '&pageSize=' + page_size.to_s + '&search=' + term)
      else
        response = @client.get('/v1/recipients/' + recipient_id + '/offlinePayments?page=' + page.to_s + '&pageSize=' + page_size.to_s + '&search=' + term)
      end

      offline_payments_list_builder(response)
    end

    def offline_payment_builder(response)
      offline_payment = OfflinePayment.new
      data = JSON.parse(response)
      data.each do |key, value|
        next unless key === 'offlinePayment'
        loosely_hydrate_model(offline_payment, value)
      end
      offline_payment
    end

    def offline_payments_list_builder(response)
      offline_payments = []
      data = JSON.parse(response)

      data.each do |key, value|
        next unless key === 'offlinePayments'
        value.each do |newKey, _newValue|
          offline_payment = loosely_hydrate_model(OfflinePayment.new, newKey)
          offline_payments.push(offline_payment)
        end
      end
      offline_payments
    end
  end
end

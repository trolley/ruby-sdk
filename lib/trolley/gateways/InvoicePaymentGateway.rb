require_relative '../Client'

module Trolley
  class InvoicePaymentGateway
    def initialize(client)
      @client = client
    end

    def create(body)
      response = @client.post('/v1/invoices/payment/create', body)
      invoice_payment_builder(response)
    end

    def update(body)
      @client.post('/v1/invoices/payment/update', body)
      true
    end

    def delete(body)
      @client.post('/v1/invoices/payment/delete', body)
      true
    end

    def search(body)
      response = @client.post('/v1/invoices/payment/search', body)
      invoice_payments_list_builder(response)
    end

    def invoice_payment_builder(response)
      Utils::ResponseMapper.build(response, InvoicePayment)
    end

    def invoice_payments_list_builder(response)
      Utils::PaginatedArray.from_response(response, InvoicePayment)
    end
  end
end

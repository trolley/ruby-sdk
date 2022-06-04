require_relative '../Client.rb'
require_relative 'GatewayHelper'

module PaymentRails
  class InvoiceGateway
    include GatewayHelper

    def initialize(client)
      @client = client
    end

    def find(body)
      response = @client.post('/v1/invoices/get', body)
      invoice_builder(response)
    end

    def create(body)
      response = @client.post('/v1/invoices/create', body)
      invoice_builder(response)
    end

    def create_line(body)
      response = @client.post('/v1/invoices/create-lines', body)
      invoice_builder(response)
    end

    def search(body)
      response = @client.post('/v1/invoices/search', body)
      invoice_list_builder(response)
    end

    def update(body)
      response = @client.post('/v1/invoices/update', body)
      invoice_builder(response)
    end

    def update_line(body)
      @client.post('/v1/invoices/update-lines', body)
      true
    end

    def delete(body)
      @client.post('/v1/invoices/delete', body)
      true
    end

    def delete_line(body)
      @client.post('/v1/invoices/delete-lines', body)
      true
    end

    def invoice_builder(response)
      invoice = Invoice.new
      data = JSON.parse(response)
      data.each do |key, value|
        next unless key === 'invoice'
        loosely_hydrate_model(invoice, value)
      end
      invoice
    end

    def invoice_list_builder(response)
      invoices = []
      data = JSON.parse(response)

      data.each do |key, value|
        next unless key === 'invoices'
        value.each do |newKey, _newValue|
          invoices.push(
            loosely_hydrate_model(Invoice.new, newKey)
          )
        end
      end
      invoices
    end
  end
end

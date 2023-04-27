require_relative '../Client'
require_relative 'GatewayHelper'

module Trolley
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
      @client.post('/v1/invoices/update', body)
      true
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
      Utils::ResponseMapper.build(response, Invoice)
    end

    def invoice_list_builder(response)
      Utils::PaginatedArray.from_response(response, Invoice)
    end
  end
end

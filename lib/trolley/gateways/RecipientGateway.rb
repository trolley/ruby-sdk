require_relative '../Client'
require_relative 'GatewayHelper'

module Trolley
  class RecipientGateway
    def initialize(client)
      @client = client
    end

    def find(recipient_id)
      response = @client.get("/v1/recipients/#{recipient_id}")
      recipient_builder(response)
    end

    def create(body)
      response = @client.post('/v1/recipients/', body)
      recipient_builder(response)
    end

    def update(recipient_id, body)
      @client.patch("/v1/recipients/#{recipient_id}", body)
      true
    end

    # @param recipient_id [String] or [Array] The id (or array of ids) of the recipient to delete
    def delete(recipient_id)
      path = '/v1/recipients/'
      body = ''

      if recipient_id.is_a?(String)
        path += recipient_id
      elsif recipient_id.is_a?(Array)
        body = { ids: recipient_id }
      else
        raise 'Invalid recipient_id type'
      end

      @client.delete(path, body)
      true
    end

    # @note This method retrieves a list of activity logs for a recipient
    def find_logs(recipient_id)
      response = @client.get("/v1/recipients/#{recipient_id}/logs")
      JSON.parse(response, object_class: OpenStruct)
    end

    def find_payments(recipient_id, page = 1, page_size = 10)
      query_string = URI.encode_www_form(
        page: page.to_s,
        pageSize: page_size.to_s
      )
      response = @client.get("/v1/recipients/#{recipient_id}/payments?#{query_string}")
      payments_list_builder(response)
    end

    # TODO: if we can afford a breaking change ideally these should be kwargs
    # rubocop:disable Metrics/ParameterLists
    def search(page = 1, page_size = 10, prefix_search = '', filters = {})
      query_string = URI.encode_www_form(
        page: page.to_s,
        pageSize: page_size.to_s,
        search: prefix_search,
        **filters
      )
      response = @client.get("/v1/recipients?#{query_string}")
      recipient_list_builder(response)
    end
    # rubocop:enable Metrics/ParameterLists

    def recipient_builder(response)
      Utils::ResponseMapper.build(response, Recipient)
    end

    def recipient_list_builder(response)
      Utils::PaginatedArray.from_response(response, Recipient)
    end

    def payments_list_builder(response)
      Utils::PaginatedArray.from_response(response, Payment)
    end
  end
end

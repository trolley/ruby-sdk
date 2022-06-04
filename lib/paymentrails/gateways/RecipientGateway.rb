require_relative '../Client.rb'
require_relative 'GatewayHelper'

module PaymentRails
  class RecipientGateway
    include GatewayHelper

    def initialize(client)
      @client = client
    end

    def find(recipient_id)
      response = @client.get('/v1/recipients/' + recipient_id)
      recipient_builder(response)
    end

    def create(body)
      response = @client.post('/v1/recipients/', body)
      recipient_builder(response)
    end

    def update(recipient_id, body)
      response = @client.patch('/v1/recipients/' + recipient_id, body)
      recipient_builder(response)
    end

    def delete(recipient_id)
      @client.delete('/v1/recipients/' + recipient_id)
      true
    end

    # TODO: if we can afford a breaking change ideally these should be kwargs
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

    def recipient_builder(response)
      recipient = Recipient.new
      data = JSON.parse(response)
      data.each do |key, value|
        next unless key === 'recipient'
        loosely_hydrate_model(recipient, value)
      end
      recipient
    end

    def recipient_list_builder(response)
      recipients = []
      data = JSON.parse(response)

      data.each do |key, value|
        next unless key === 'recipients'
        value.each do |newKey, _newValue|
          recipient = loosely_hydrate_model(Recipient.new, newKey)
          recipients.push(recipient)
        end
      end
      recipients
    end
  end
end

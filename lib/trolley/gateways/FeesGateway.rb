require_relative '../Client'

module Trolley
  class FeesGateway
    def initialize(client)
      @client = client
    end

    def search_route_pricing(body = {})
      response = @client.post('/v1/fees/route-pricing/search', body)
      Utils::ResponseMapper.build(response, Fee)
    end

    def create_revenue_stream(body)
      response = @client.post('/v1/fees/revenue-stream/create', body)
      Utils::ResponseMapper.build(response, RevenueStream)
    end

    def update_revenue_stream(body)
      response = @client.post('/v1/fees/revenue-stream/update', body)
      Utils::ResponseMapper.build(response, RevenueStream)
    end
  end
end

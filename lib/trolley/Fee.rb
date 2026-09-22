module Trolley
  class Fee
    attr_accessor :currencyCode
    attr_reader :revenueStream

    def revenueStream=(revenue_streams)
      @revenueStream = revenue_streams.transform_values do |routes|
        routes.transform_values { |attributes| RevenueStream.from_hash(attributes) }
      end
    end
  end
end

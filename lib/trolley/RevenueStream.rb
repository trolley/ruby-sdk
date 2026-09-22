module Trolley
  class RevenueStream
    attr_accessor(
      :currencyCode,
      :integration,
      :routeType,
      :merchantAmountType,
      :merchantAmount,
      :guardrails,
      :percentCap,
      :revenueShareId
    )

    def self.from_hash(attributes)
      new.tap do |revenue_stream|
        attributes.each do |key, value|
          revenue_stream.public_send("#{key}=", value)
        rescue NoMethodError
          nil
        end
      end
    end
  end
end

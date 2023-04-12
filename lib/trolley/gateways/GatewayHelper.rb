module Trolley
  module GatewayHelper
    def loosely_hydrate_model(klass_instance, attributes)
      attributes.each do |k, v|
        klass_instance.send("#{k}=", v)
      rescue NoMethodError
        # TODO: The API is showing non-public attributes, once we remove them from the API response we can re-add this warning.
        # warn "[PaymentRails] Unknown attribute #{k} for class #{klass_instance.class.name}"
      end

      klass_instance
    end
  end
end

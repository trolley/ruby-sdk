module PaymentRails
  module GatewayHelper
    # rubocop:disable Lint/SuppressedException
    def loosely_hydrate_model(klass_instance, attributes)
      attributes.each do |k, v|
        begin
          klass_instance.send("#{k}=", v)
        rescue NoMethodError
          # TODO: The API is showing non-public attributes, once we remove them from the API response we can re-add this warning.
          # warn "[PaymentRails] Unknown attribute #{k} for class #{klass_instance.class.name}"
        end
      end

      klass_instance
    end
    # rubocop:enable Lint/SuppressedException
  end
end

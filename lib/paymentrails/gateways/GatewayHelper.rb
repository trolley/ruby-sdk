module PaymentRails
  module GatewayHelper
    def loosely_hydrate_model(klass_instance, attributes)
      attributes.each do |k, v|
        begin
          klass_instance.send("#{k}=", v)
        rescue NoMethodError
          warn "[PaymentRails] Unknown attribute #{k} for class #{klass_instance.class.name}"
        end
      end

      klass_instance
    end
  end
end


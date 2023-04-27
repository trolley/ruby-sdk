# frozen_string_literal: true

module Trolley
  module Utils
    class ResponseMapper
      KLASS_TO_RESOURCE_KEY_MAPPERS = {
        'Trolley::Batch' => { resource: 'batch', collection: 'batches' },
        'Trolley::Invoice' => { resource: 'invoice', collection: 'invoices' },
        'Trolley::InvoicePayment' => { resource: 'invoicePayment', collection: 'invoicePayments' },
        'Trolley::OfflinePayment' => { resource: 'offlinePayment', collection: 'offlinePayments' },
        'Trolley::Payment' => { resource: 'payment', collection: 'payments' },
      }.freeze

      def self.build(response, klass)
        new(response, klass).build
      end

      def initialize(response, klass)
        @response = response
        @klass = klass
        @data = JSON.parse(response)
      end

      def build
        if collection?
          build_collection
        else
          build_resource
        end
      end

      private

      attr_reader :response, :klass, :data

      def build_collection
        data[applicable_collection_key].map do |resource_data|
          build_resource(resource_data)
        end
      end

      def build_resource(resource_data = nil)
        resource_data ||= data[applicable_resource_key]
        loosely_hydrate_model(resource_data)
      end

      def loosely_hydrate_model(resource_data)
        instance = klass.new

        resource_data.each do |k, v|
          instance.send("#{k}=", v)
        rescue NoMethodError
          # TODO: The API is showing non-public attributes, once we remove them from the API response we can re-add this warning.
          # warn "[PaymentRails] Unknown attribute #{k} for class #{klass_instance.class.name}"
        end

        instance
      end

      def collection?
        data[applicable_collection_key].is_a?(Array)
      end

      def applicable_collection_key
        applicable_mapper[:collection]
      end

      def applicable_resource_key
        applicable_mapper[:resource]
      end

      def applicable_mapper
        KLASS_TO_RESOURCE_KEY_MAPPERS.fetch(klass.to_s)
      end
    end
  end
end

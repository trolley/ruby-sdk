module Trolley
  module Utils
    class PaginatedArray < Array
      attr_accessor :page, :pages, :records, :ok

      def self.from_response(response, klass)
        data = JSON.parse(response)

        enum = Utils::ResponseMapper.new(response, klass).build
        page = data.dig('meta', 'page')
        pages = data.dig('meta', 'pages')
        records = data.dig('meta', 'records')
        collection_key = data.keys.find { |key| data[key].is_a?(Array) }

        new(enum, page, pages, records, ok: data['ok'], collection_key:)
      end

      def initialize(enum, page, pages, records, metadata = {})
        super(enum)
        @page = page
        @pages = pages
        @records = records
        @ok = metadata[:ok]

        collection_key = metadata[:collection_key]
        define_singleton_method(collection_key) { self } unless collection_key.nil?
      end
    end
  end
end

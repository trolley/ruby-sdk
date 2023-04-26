module Trolley
  module Utils
    class PaginatedArray < Array
      attr_accessor :page, :pages, :records

      def self.from_response(response, klass)
        data = JSON.parse(response)

        enum = Utils::ResponseMapper.new(response, klass).build
        page = data.dig('meta', 'page')
        pages = data.dig('meta', 'pages')
        records = data.dig('meta', 'records')

        new(enum, page, pages, records)
      end

      def initialize(enum, page, pages, records)
        super(enum)
        @page = page
        @pages = pages
        @records = records
      end
    end
  end
end

require_relative '../Client'

module Trolley
  class BatchGateway
    def initialize(client)
      @client = client
    end

    def find(batch_id)
      response = @client.get("/v1/batches/#{batch_id}")
      batch_builder(response)
    end

    def all
      response = @client.get('/v1/batches/')
      batch_list_builder(response)
    end

    def create(body)
      response = @client.post('/v1/batches/', body)
      batch_builder(response)
    end

    def update(batch_id, body)
      @client.patch("/v1/batches/#{batch_id}", body)
      true
    end

    # @param batch_id [String] or [Array] The id (or array of ids) of the batch to delete
    def delete(batch_id)
      path = '/v1/batches/'
      body = ''

      if batch_id.is_a?(String)
        path += batch_id
      elsif batch_id.is_a?(Array)
        body = { ids: batch_id }
      else
        raise 'Invalid batch_id type, please pass a string or array of strings'
      end

      @client.delete(path, body)
      true
    end

    def generate_quote(batch_id)
      response = @client.post("/v1/batches/#{batch_id}/generate-quote", {})
      batch_builder(response)
    end

    def start_processing(batch_id)
      response = @client.post("/v1/batches/#{batch_id}/start-processing", {})
      batch_builder(response)
    end

    def search(page = 1, page_size = 10, term = '')
      response = @client.get("/v1/batches?page=#{page}&pageSize=#{page_size}&search=#{term}")
      batch_list_builder(response)
    end

    def batch_builder(response)
      Utils::ResponseMapper.build(response, Batch)
    end

    def summary(batch_id)
      response = @client.get("/v1/batches/#{batch_id}/summary")
      Utils::ResponseMapper.build(response, BatchSummary)
    end

    def batch_list_builder(response)
      Utils::PaginatedArray.from_response(response, Batch)
    end
  end
end

require_relative 'Client.rb'

class BatchGateway
  def initialize(client)
    @client = client
  end

  def find(batch_id)
    response = @client.get('/v1/batches/' + batch_id)
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
    @client.patch('/v1/batches/' + batch_id, body)
    true
  end

  def delete(batch_id)
    @client.delete('/v1/batches/' + batch_id)
    true
  end

  def generate_quote(batch_id)
    response = @client.post('/v1/batches/' + batch_id + '/generate-quote', {})
    batch_builder(response)
  end

  def start_processing(batch_id)
    response = @client.post('/v1/batches/' + batch_id + '/start-processing', {})
    batch_builder(response)
  end

  def search(page = 1, page_number = 10, term = '')
    response = @client.get('/v1/batches/?search=' + term + 'page=' + page + '&pageSize=' + page_number)
    batch_list_builder(response)
  end

  def batch_builder(response)
    batch = Batch.new
    data = JSON.parse(response)
    data.each do |key, value|
      next unless key === 'batch'
      value.each do |newKey, newValue|
        batch.send("#{newKey}=", newValue)
      end
    end
    batch
  end

  def summary(batch_id)
    response = @client.get('/v1/batches/' + batch_id + '/summary')
    summary = BatchSummary.new
    data = JSON.parse(response)
    data.each do |key, value|
      next unless key === 'batchSummary'
      value.each do |newKey, newValue|
        summary.send("#{newKey}=", newValue)
      end
    end
    summary
  end

  def batch_list_builder(response)
    batches = []
    data = JSON.parse(response)

    data.each do |key, value|
      next unless key === 'batches'
      value.each do |newKey, _newValue|
        batch = Batch.new
        newKey.each do |key1, value1|
          batch.send("#{key1}=", value1)
        end
        batches.push(batch)
      end
    end
    batches
  end
end

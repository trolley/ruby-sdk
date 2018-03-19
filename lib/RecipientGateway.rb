require_relative 'Client.rb'

class RecipientGateway
  def initialize(client)
    @client = client
  end

  def find(recipient_id)
    response = @client.get('/v1/recipients/' + recipient_id)
    recipient_builder(response)
  end

  def create(body)
    response = @client.post('/v1/recipients/', body)
    recipient_builder(response)
  end

  def update(recipient_id, body)
    @client.patch('/v1/recipients/' + recipient_id, body)
    true
  end

  def delete(recipient_id)
    @client.delete('/v1/recipients/' + recipient_id)
    true
  end

  def search(page = 1, page_number = 10, term = '')
    response = @client.get('/v1/recipients?search=' + term + 'page=' + page + '&pageSize=' + page_number)
    recipient_list_builder(response)
  end

  def recipient_builder(response)
    recipient = Recipient.new
    data = JSON.parse(response)
    data.each do |key, value|
      next unless key === 'recipient'
      value.each do |recipKey, recipValue|
        recipient.send("#{recipKey}=", recipValue)
      end
    end
    recipient
  end

  def recipient_list_builder(response)
    recipients = []
    data = JSON.parse(response)

    data.each do |key, value|
      next unless key === 'recipients'
      value.each do |newKey, _newValue|
        recipient = Recipient.new
        newKey.each do |key1, value1|
          recipient.send("#{key1}=", value1)
        end
        recipients.push(recipient)
      end
    end
    recipients
  end
end

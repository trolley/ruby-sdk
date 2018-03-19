require_relative 'Client.rb'

class RecipientAccountGateway
  def initialize(client)
    @client = client
  end

  def find(recipient_id, recipient_account_id)
    response = @client.get('/v1/recipients/' + recipient_id + '/accounts/' + recipient_account_id)
    recipient_account_builder(response)
  end

  def all(recipient_id)
    response = @client.get('/v1/recipients/' + recipient_id + '/accounts/')
    recipient_account_list_builder(response)
  end

  def create(recipient_id, body)
    response = @client.post('/v1/recipients/' + recipient_id + '/accounts', body)
    recipient_account_builder(response)
  end

  def update(recipient_id, recipient_account_id, body)
    response = @client.patch('/v1/recipients/' + recipient_id, + '/accounts/' + recipient_account_id, body)
    recipient_account_builder(response)
  end

  def delete(recipient_id, recipient_account_id)
    @client.delete('/v1/recipients/' + recipient_id + '/accounts/' + recipient_account_id)
    true
  end

  def recipient_account_builder(response)
    recipient_account = RecipientAccount.new
    data = JSON.parse(response)
    data.each do |key, value|
      next unless key === 'account'
      value.each do |recipKey, recipValue|
        recipient_account.send("#{recipKey}=", recipValue)
      end
    end
    recipient_account
  end

  def recipient_account_list_builder(response)
    recipient_accounts = []
    data = JSON.parse(response)

    data.each do |key, value|
      next unless key === 'accounts'
      value.each do |newKey, _newValue|
        recipient_account = RecipientAccount.new
        newKey.each do |key1, value1|
          recipient_account.send("#{key1}=", value1)
        end
        recipient_accounts.push(recipient_account)
      end
    end
    recipient_accounts
  end
end

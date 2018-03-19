require_relative 'Client.rb'

class PaymentGateway
  def initialize(client)
    @client = client
  end

  def find(batch_id, payment_id)
    response = @client.get('/v1/batches/' + batch_id + '/payments/' + payment_id)
    payment_builder(response)
  end

  def create(batch_id, body)
    response = @client.post('/v1/batches/' + batch_id + '/payments', body)
    payment_builder(response)
  end

  def update(batch_id, payment_id, body)
    @client.patch('/v1/batches/' + batch_id + '/payments/' + payment_id, body)
    true
  end

  def delete(batch_id, payment_id)
    @client.delete('/v1/batches/' + batch_id + '/payments/' + payment_id)
    true
  end

  def search(batch_id, page = 1, page_number = 10, term = '')
    response = @client.get('/v1/batches/' + batch_id.to_s + '/payments?' + 'page=' + page.to_s + '&pageSize=' + page_number.to_s + '&search=' + term)
    payments_list_builder(response)
  end

  def payment_builder(response)
    payment = Payment.new
    data = JSON.parse(response)
    data.each do |key, value|
      next unless key === 'payment'
      value.each do |recipKey, recipValue|
        payment.send("#{recipKey}=", recipValue)
      end
    end
    payment
  end

  def payments_list_builder(response)
    payments = []
    data = JSON.parse(response)

    data.each do |key, value|
      next unless key === 'payments'
      value.each do |newKey, _newValue|
        payment = Payment.new
        newKey.each do |key1, value1|
          payment.send("#{key1}=", value1)
        end
        payments.push(payment)
      end
    end
    payments
  end
end

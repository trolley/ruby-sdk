class PaymentRails
  attr_reader :recipient
  attr_writer :recipient

  attr_reader :recipient_account
  attr_writer :recipient_account

  attr_reader :batch
  attr_writer :batch

  attr_reader :payment
  attr_writer :payment

  attr_reader :balance
  attr_writer :balance

  def initialize(key, secret, environment = 'production')
    load 'Configuration.rb'
    load 'Gateway.rb'

    client = Gateway.new(Configuration.new(key, secret, environment))
    @recipient = client.recipient
    @recipient_account = client.recipient_account
    @batch = client.batch
    @payment = client.payment
    @balance = client.balance

    # to avoid overriding potential global Configuration & Gateway
    Object.send(:remove_const, :Gateway)
    Object.send(:remove_const, :Configuration)
  end

end
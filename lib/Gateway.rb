require_relative 'RecipientGateway.rb'
require_relative 'RecipientAccountGateway.rb'
require_relative 'BatchGateway.rb'
require_relative 'PaymentGateway.rb'

class Gateway
  attr_reader :config
  attr_writer :config

  attr_reader :client
  attr_writer :client

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

  def initialize(config)
    @config = config
    @client = Client.new(config)
    @recipient = RecipientGateway.new(client)
    @recipient_account = RecipientAccountGateway.new(client)
    @batch = BatchGateway.new(client)
    @payment = PaymentGateway.new(client)
    @balance = BalanceGateway.new(client)
  end
end

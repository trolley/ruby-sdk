# class PaymentRails
#   attr_reader :recipient
#   attr_writer :recipient

#   attr_reader :recipient_account
#   attr_writer :recipient_account

#   attr_reader :batch
#   attr_writer :batch

#   attr_reader :payment
#   attr_writer :payment

#   attr_reader :balance
#   attr_writer :balance

#   def initialize(key, secret, environment = 'production')
#     load 'Configuration.rb'
#     load 'Gateway.rb'

#     client = Gateway.new(Configuration.new(key, secret, environment))
#     @recipient = client.recipient
#     @recipient_account = client.recipient_account
#     @batch = client.batch
#     @payment = client.payment
#     @balance = client.balance

#     # to avoid overriding potential global Configuration & Gateway
#     Object.send(:remove_const, :Gateway)
#     Object.send(:remove_const, :Configuration)
#   end

# end

require 'paymentrails/Configuration'
require 'paymentrails/Gateway'

require 'paymentrails/gateways/BalanceGateway'
require 'paymentrails/gateways/BatchGateway'
require 'paymentrails/gateways/PaymentGateway'
require 'paymentrails/gateways/RecipientGateway'
require 'paymentrails/gateways/RecipientAccountGateway'

require 'paymentrails/Balance'
require 'paymentrails/Batch'
require 'paymentrails/BatchSummary'
require 'paymentrails/Exceptions'
require 'paymentrails/Payment'
require 'paymentrails/Recipient'
require 'paymentrails/RecipientAccount'

module PaymentRails
  def self.client(key, secret, environment = 'production')
    client = Gateway.new(Configuration.new(key, secret, environment))
    return client
  end
end
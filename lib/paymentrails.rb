require 'paymentrails/Configuration'
require 'paymentrails/Gateway'

require 'paymentrails/gateways/BalanceGateway'
require 'paymentrails/gateways/BatchGateway'
require 'paymentrails/gateways/PaymentGateway'
require 'paymentrails/gateways/RecipientGateway'
require 'paymentrails/gateways/RecipientAccountGateway'
require 'paymentrails/gateways/OfflinePaymentGateway'

require 'paymentrails/Balance'
require 'paymentrails/Batch'
require 'paymentrails/BatchSummary'
require 'paymentrails/Exceptions'
require 'paymentrails/Payment'
require 'paymentrails/Recipient'
require 'paymentrails/RecipientAccount'
require 'paymentrails/OfflinePayment'

module PaymentRails
  def self.client(key, secret, environment = 'production')
    client = Gateway.new(Configuration.new(key, secret, environment))
    return client
  end
end

require 'paymentrails/Configuration'
require 'paymentrails/Gateway'

require 'paymentrails/gateways/BalanceGateway'
require 'paymentrails/gateways/BatchGateway'
require 'paymentrails/gateways/PaymentGateway'
require 'paymentrails/gateways/RecipientGateway'
require 'paymentrails/gateways/RecipientAccountGateway'
require 'paymentrails/gateways/OfflinePaymentGateway'
require 'paymentrails/gateways/InvoiceGateway'
require 'paymentrails/gateways/InvoicePaymentGateway'

require 'paymentrails/Balance'
require 'paymentrails/Batch'
require 'paymentrails/BatchSummary'
require 'paymentrails/Exceptions'
require 'paymentrails/Payment'
require 'paymentrails/Recipient'
require 'paymentrails/RecipientAccount'
require 'paymentrails/OfflinePayment'
require 'paymentrails/Invoice'
require 'paymentrails/InvoicePayment'

module PaymentRails
  def self.client(key, secret, environment = 'production', **optionals)
    Gateway.new(Configuration.new(key, secret, environment, optionals))
  end
end

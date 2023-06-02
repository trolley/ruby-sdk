require 'trolley/Configuration'
require 'trolley/Gateway'

require 'trolley/gateways/BalanceGateway'
require 'trolley/gateways/BatchGateway'
require 'trolley/gateways/PaymentGateway'
require 'trolley/gateways/RecipientGateway'
require 'trolley/gateways/RecipientAccountGateway'
require 'trolley/gateways/OfflinePaymentGateway'
require 'trolley/gateways/InvoiceGateway'
require 'trolley/gateways/InvoicePaymentGateway'

require 'trolley/utils/PaginatedArray'
require 'trolley/utils/ResponseMapper'

require 'trolley/Balance'
require 'trolley/Batch'
require 'trolley/BatchSummary'
require 'trolley/Exceptions'
require 'trolley/Payment'
require 'trolley/Recipient'
require 'trolley/RecipientAccount'
require 'trolley/OfflinePayment'
require 'trolley/Invoice'
require 'trolley/InvoicePayment'

module Trolley
  VERSION = '1.0.2'.freeze

  def self.client(key, secret, **optionals)
    Gateway.new(Configuration.new(key, secret, **optionals))
  end
end

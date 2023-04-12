module Trolley
  class Gateway
    attr_accessor :config, :client, :recipient, :recipient_account, :batch, :payment, :balance, :offline_payment, :invoice, :invoice_payment

    def initialize(config)
      @config = config
      @client = Client.new(config)
      @recipient = RecipientGateway.new(client)
      @recipient_account = RecipientAccountGateway.new(client)
      @batch = BatchGateway.new(client)
      @payment = PaymentGateway.new(client)
      @balance = BalanceGateway.new(client)
      @offline_payment = OfflinePaymentGateway.new(client)
      @invoice = InvoiceGateway.new(client)
      @invoice_payment = InvoicePaymentGateway.new(client)
    end
  end
end

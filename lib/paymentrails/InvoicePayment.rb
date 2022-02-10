module PaymentRails
  class InvoicePayment
    attr_accessor(
      :id,
      :batchId,
      :paymentId,
      :invoiceId,
      :invoiceLineId,
      :amount,
      :invoicePayments
    )
  end
end

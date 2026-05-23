module Trolley
  class InvoicePayment
    attr_accessor(
      :id,
      :batchId,
      :paymentId,
      :invoiceId,
      :invoiceLineId,
      :amount,
      :invoicePayments,
      :status,
      :memo,
      :externalId,
      :tags,
      :coverFees
    )
  end
end

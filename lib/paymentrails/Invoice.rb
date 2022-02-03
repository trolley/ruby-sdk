module PaymentRails
  class Invoice
    attr_accessor(
      :id,
      :description,
      :externalId,
      :invoiceDate,
      :dueDate,
      :invoiceNumber,
      :status,
      :releaseAfter,
      :createdAt,
      :updatedAt,
      :totalAmount,
      :paidAmount,
      :dueAmount,
      :tags,
      :recipientId,
      :lines,
    )
  end
end

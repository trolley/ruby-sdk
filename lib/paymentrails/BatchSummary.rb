module PaymentRails
  class BatchSummary
    attr_accessor(
      :id,
      :accounts,
      :amount,
      :batchId,
      :balances,
      :completedAt,
      :createdAt,
      :currency,
      :description,
      :detail,
      :methods,
      :sentAt,
      :status,
      :totalPayments,
      :updatedAt,
      :total,
    )
  end
end

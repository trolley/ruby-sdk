module PaymentRails
  class OfflinePayment
    attr_accessor(
      :id,
      :recipientId,
      :externalId,
      :memo,
      :tags,
      :taxReportable,
      :category,
      :amount,
      :currency,
      :withholdingAmount,
      :withholdingCurrency,
      :processedAt,
      :equivalentWithholdingAmount,
      :equivalentWithholdingCurrency,
      :updatedAt,
      :createdAt,
      :deletedAt
    )
  end
end

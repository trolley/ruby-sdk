module PaymentRails
  class OfflinePayment
    attr_accessor :id, :recipientId, :externalId, :memo, :tags, :taxReportable, :category, :amount, :currency, :withholdingAmount, :withholdingCurrency, :processedAt, :equivalentWithholdingAmount, :equivalentWithholdingCurrency, :updatedAt, :createdAt, :deletedAt
    attr_writer :id, :externalId, :memo, :tags, :taxReportable, :category, :amount, :currency, :withholdingAmount, :withholdingCurrency, :processedAt
  end
end

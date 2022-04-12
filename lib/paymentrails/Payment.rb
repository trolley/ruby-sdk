module PaymentRails
  class Payment
    attr_accessor(
      :id,
      :account,
      :amount,
      :batch,
      :category,
      :checkNumber,
      :compliance,
      :coverFees,
      :createdAt,
      :currency,
      :equivalentWithholdingAmount,
      :equivalentWithholdingCurrency,
      :estimatedDeliveryAt,
      :exchangeRate,
      :externalId,
      :failureMessage,
      :fees,
      :forceUsTaxActivity,
      :fxRate,
      :initiatedAt,
      :isSupplyPayment,
      :memo,
      :merchantFees,
      :merchantId,
      :methodDisplay,
      :payoutMethod,
      :processedAt,
      :recipient,
      :recipientFees,
      :returnedAmount,
      :returnedAt,
      :returnedNote,
      :returnedReason,
      :settledAt,
      :sourceAmount,
      :sourceCurrency,
      :status,
      :tags,
      :targetAmount,
      :targetCurrency,
      :taxBasisAmount,
      :taxBasisCurrency,
      :taxes,
      :taxReportable,
      :updatedAt,
      :withholdingAmount,
      :withholdingCurrency,
    )
  end
end

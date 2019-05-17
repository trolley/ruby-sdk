class RecipientAccount
  attr_accessor	:id, :primary, :currency, :recipientAccountId, :routeType, :recipientFees, :emailAddress, :country, :type, :iban, :accountNum, :accountHolderName, :swiftBic, :branchId, :bankId, :bankName, :bankAddress, :bankCity, :bankRegionCode, :bankPostalCode, :status, :disabledAt
  attr_writer	:id, :primary, :currency, :recipientAccountId, :routeType, :recipientFees, :emailAddress, :country, :type, :iban, :accountNum, :accountHolderName, :swiftBic, :branchId, :bankId, :bankName, :bankAddress, :bankCity, :bankRegionCode, :bankPostalCode, :status, :disabledAt
end

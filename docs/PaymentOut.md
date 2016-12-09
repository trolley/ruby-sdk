# SwaggerClient::PaymentOut

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | P-XXXXXXXXXXXXXXXX | [optional] 
**source_amount** | **Float** |  | [optional] 
**source_currency** | **String** | source currency code | [optional] 
**source_currency_name** | **String** | currency name | [optional] 
**target_amount** | **Float** |  | [optional] 
**target_currency** | **String** | target currency code 3 letters ISO code | [optional] 
**target_currency_name** | **String** | currency name | [optional] 
**recipient_fees** | **Float** |  | [optional] 
**fx_rate** | **Float** |  | [optional] 
**memo** | **String** |  | [optional] 
**status** | **String** |  | [optional] 
**merchant_fees** | **Float** |  | [optional] 
**recipient** | [**Recipient**](Recipient.md) |  | [optional] 
**compliance** | [**PaymentComplianceStatus**](PaymentComplianceStatus.md) |  | [optional] 
**batch** | [**PaymentBatch**](PaymentBatch.md) |  | [optional] 
**processed_at** | **String** | processing date | [optional] 
**updated_at** | **String** | last update date | [optional] 
**created_at** | **String** | creation date | [optional] 



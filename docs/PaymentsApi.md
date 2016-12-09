# SwaggerClient::PaymentsApi

All URIs are relative to *http://local.dev:3000/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**query**](PaymentsApi.md#query) | **GET** /v1/payments | 
[**v1_payments_payment_id_get**](PaymentsApi.md#v1_payments_payment_id_get) | **GET** /v1/payments/{paymentId} | 


# **query**
> InlineResponse2001 query(opts)



### Example
```ruby
# load the gem
require 'swagger_client'
# setup authorization
SwaggerClient.configure do |config|
  # Configure API key authorization: merchantKey
  config.api_key['x-api-key'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['x-api-key'] = 'Bearer'
end

api_instance = SwaggerClient::PaymentsApi.new

opts = { 
  page: 56, # Integer | page number default 1
  page_size: 56, # Integer | page size default 100
  start_date: "start_date_example", # String | filter recipients list by creation date from start date format YYYY-MM-DD
  end_date: "end_date_example", # String | filter recipients list by creation date to end date format YYYY-MM-DD
  status: "status_example", # String | filter recipients list by status
  country: "country_example", # String | filter by 2 letter country code
  recipient: "recipient_example", # String | filter by recipient ID R-XXXXXXXXXXXXXXXX
  source_currency: "source_currency_example", # String | filter by source currency 3 letters ISO code
  target_currency: "target_currency_example" # String | filter by target currency 3 letters ISO code
}

begin
  result = api_instance.query(opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling PaymentsApi->query: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **Integer**| page number default 1 | [optional] 
 **page_size** | **Integer**| page size default 100 | [optional] 
 **start_date** | **String**| filter recipients list by creation date from start date format YYYY-MM-DD | [optional] 
 **end_date** | **String**| filter recipients list by creation date to end date format YYYY-MM-DD | [optional] 
 **status** | **String**| filter recipients list by status | [optional] 
 **country** | **String**| filter by 2 letter country code | [optional] 
 **recipient** | **String**| filter by recipient ID R-XXXXXXXXXXXXXXXX | [optional] 
 **source_currency** | **String**| filter by source currency 3 letters ISO code | [optional] 
 **target_currency** | **String**| filter by target currency 3 letters ISO code | [optional] 

### Return type

[**InlineResponse2001**](InlineResponse2001.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **v1_payments_payment_id_get**
> PaymentOut v1_payments_payment_id_get(payment_id)



### Example
```ruby
# load the gem
require 'swagger_client'
# setup authorization
SwaggerClient.configure do |config|
  # Configure API key authorization: merchantKey
  config.api_key['x-api-key'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['x-api-key'] = 'Bearer'
end

api_instance = SwaggerClient::PaymentsApi.new

payment_id = "payment_id_example" # String | P-XXXXXXXXXXXXXXXX


begin
  result = api_instance.v1_payments_payment_id_get(payment_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling PaymentsApi->v1_payments_payment_id_get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payment_id** | **String**| P-XXXXXXXXXXXXXXXX | 

### Return type

[**PaymentOut**](PaymentOut.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined




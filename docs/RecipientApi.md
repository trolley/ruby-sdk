# SwaggerClient::RecipientApi

All URIs are relative to *http://local.dev:3000/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**creat_paypal_account**](RecipientApi.md#creat_paypal_account) | **POST** /v1/recipients/{recipientId}/payout-methods/accounts/paypal | 
[**create_bank_account**](RecipientApi.md#create_bank_account) | **POST** /v1/recipients/{recipientId}/payout-methods/accounts/bank | 
[**create_payout_methods**](RecipientApi.md#create_payout_methods) | **POST** /v1/recipients/{recipientId}/payout-methods | 
[**delete**](RecipientApi.md#delete) | **DELETE** /v1/recipients/{recipientId} | 
[**get**](RecipientApi.md#get) | **GET** /v1/recipients/{recipientId} | 
[**get_bank_account**](RecipientApi.md#get_bank_account) | **GET** /v1/recipients/{recipientId}/payout-methods/accounts/bank | 
[**get_compliance_checks**](RecipientApi.md#get_compliance_checks) | **GET** /v1/recipients/{recipientId}/compliance | 
[**get_info**](RecipientApi.md#get_info) | **GET** /v1/recipients/{recipientId}/info | 
[**get_logs**](RecipientApi.md#get_logs) | **GET** /v1/recipients/{recipientId}/logs | 
[**get_payments**](RecipientApi.md#get_payments) | **GET** /v1/recipients/{recipientId}/payments | 
[**get_payout_methods**](RecipientApi.md#get_payout_methods) | **GET** /v1/recipients/{recipientId}/payout-methods | 
[**get_paypal_account**](RecipientApi.md#get_paypal_account) | **GET** /v1/recipients/{recipientId}/payout-methods/accounts/paypal | 
[**update**](RecipientApi.md#update) | **PATCH** /v1/recipients/{recipientId} | 
[**update_bank_account**](RecipientApi.md#update_bank_account) | **PATCH** /v1/recipients/{recipientId}/payout-methods/accounts/bank | 
[**update_info**](RecipientApi.md#update_info) | **PATCH** /v1/recipients/{recipientId}/info | 
[**update_payout_methods**](RecipientApi.md#update_payout_methods) | **PATCH** /v1/recipients/{recipientId}/payout-methods | 
[**update_paypal_account**](RecipientApi.md#update_paypal_account) | **PATCH** /v1/recipients/{recipientId}/payout-methods/accounts/paypal | 


# **creat_paypal_account**
> PaypalAccount creat_paypal_account(recipient_id, body)



create paypal account

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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | 

body = SwaggerClient::PaypalAccount.new # PaypalAccount | paypal payout account


begin
  result = api_instance.creat_paypal_account(recipient_id, body)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->creat_paypal_account: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**|  | 
 **body** | [**PaypalAccount**](PaypalAccount.md)| paypal payout account | 

### Return type

[**PaypalAccount**](PaypalAccount.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **create_bank_account**
> BankAccount create_bank_account(recipient_id, body)



create bank account

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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | 

body = SwaggerClient::BankAccount.new # BankAccount | 


begin
  result = api_instance.create_bank_account(recipient_id, body)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->create_bank_account: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**|  | 
 **body** | [**BankAccount**](BankAccount.md)|  | 

### Return type

[**BankAccount**](BankAccount.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **create_payout_methods**
> RecipientPayoutMethods create_payout_methods(recipient_id, body)



create recipient payout methods

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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | R-XXXXXXXXXXXXXXXX

body = SwaggerClient::RecipientPayoutMethods.new # RecipientPayoutMethods | 


begin
  result = api_instance.create_payout_methods(recipient_id, body)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->create_payout_methods: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**| R-XXXXXXXXXXXXXXXX | 
 **body** | [**RecipientPayoutMethods**](RecipientPayoutMethods.md)|  | 

### Return type

[**RecipientPayoutMethods**](RecipientPayoutMethods.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **delete**
> delete(recipient_id)



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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | R-XXXXXXXXXXXXXXXX


begin
  api_instance.delete(recipient_id)
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->delete: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**| R-XXXXXXXXXXXXXXXX | 

### Return type

nil (empty response body)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **get**
> Recipient get(recipient_id)



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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | R-XXXXXXXXXXXXXXXX


begin
  result = api_instance.get(recipient_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**| R-XXXXXXXXXXXXXXXX | 

### Return type

[**Recipient**](Recipient.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **get_bank_account**
> BankAccount get_bank_account(recipient_id)



create bank account

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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | 


begin
  result = api_instance.get_bank_account(recipient_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->get_bank_account: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**|  | 

### Return type

[**BankAccount**](BankAccount.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **get_compliance_checks**
> InlineResponse2002 get_compliance_checks(recipient_id)



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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | 


begin
  result = api_instance.get_compliance_checks(recipient_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->get_compliance_checks: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**|  | 

### Return type

[**InlineResponse2002**](InlineResponse2002.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **get_info**
> RecipientInfoOut get_info(recipient_id)



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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | R-XXXXXXXXXXXXXXXX


begin
  result = api_instance.get_info(recipient_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->get_info: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**| R-XXXXXXXXXXXXXXXX | 

### Return type

[**RecipientInfoOut**](RecipientInfoOut.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **get_logs**
> InlineResponse2003 get_logs(recipient_id)



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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | R-XXXXXXXXXXXXXX


begin
  result = api_instance.get_logs(recipient_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->get_logs: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**| R-XXXXXXXXXXXXXX | 

### Return type

[**InlineResponse2003**](InlineResponse2003.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **get_payments**
> InlineResponse2004 get_payments(recipient_id, opts)



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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | R-XXXXXXXXXXXXXXXX

opts = { 
  page: 56, # Integer | set page number default 1
  page_size: 56, # Integer | set page size default 100
  status: "status_example", # String | filter recipient payment by status
  start_date: "start_date_example", # String | filter recipient payment creation date from date
  end_date: "end_date_example", # String | filter recipient payment creation date to date
  source_currency: "source_currency_example", # String | filter recipient payments by source currency, 3 letters ISO code
  search: "search_example" # String | search payments using key words, payment ids, names
}

begin
  result = api_instance.get_payments(recipient_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->get_payments: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**| R-XXXXXXXXXXXXXXXX | 
 **page** | **Integer**| set page number default 1 | [optional] 
 **page_size** | **Integer**| set page size default 100 | [optional] 
 **status** | **String**| filter recipient payment by status | [optional] 
 **start_date** | **String**| filter recipient payment creation date from date | [optional] 
 **end_date** | **String**| filter recipient payment creation date to date | [optional] 
 **source_currency** | **String**| filter recipient payments by source currency, 3 letters ISO code | [optional] 
 **search** | **String**| search payments using key words, payment ids, names | [optional] 

### Return type

[**InlineResponse2004**](InlineResponse2004.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **get_payout_methods**
> RecipientPayoutMethods get_payout_methods(recipient_id)



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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | R-XXXXXXXXXXXXXXXX


begin
  result = api_instance.get_payout_methods(recipient_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->get_payout_methods: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**| R-XXXXXXXXXXXXXXXX | 

### Return type

[**RecipientPayoutMethods**](RecipientPayoutMethods.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **get_paypal_account**
> PaypalAccount get_paypal_account(recipient_id)



get paypal account for recipient

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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | 


begin
  result = api_instance.get_paypal_account(recipient_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->get_paypal_account: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**|  | 

### Return type

[**PaypalAccount**](PaypalAccount.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **update**
> Recipient update(recipient_id, opts)



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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | R-XXXXXXXXXXXXXXXX

opts = { 
  body: SwaggerClient::RecipientPost.new # RecipientPost | 
}

begin
  result = api_instance.update(recipient_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->update: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**| R-XXXXXXXXXXXXXXXX | 
 **body** | [**RecipientPost**](RecipientPost.md)|  | [optional] 

### Return type

[**Recipient**](Recipient.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **update_bank_account**
> BankAccount update_bank_account(recipient_id, body)



create bank account

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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | 

body = SwaggerClient::BankAccount.new # BankAccount | 


begin
  result = api_instance.update_bank_account(recipient_id, body)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->update_bank_account: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**|  | 
 **body** | [**BankAccount**](BankAccount.md)|  | 

### Return type

[**BankAccount**](BankAccount.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **update_info**
> RecipientInfoOut update_info(recipient_id, body)



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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | R-XXXXXXXXXXXXXXXX

body = SwaggerClient::RecipientInfoIn.new # RecipientInfoIn | 


begin
  result = api_instance.update_info(recipient_id, body)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->update_info: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**| R-XXXXXXXXXXXXXXXX | 
 **body** | [**RecipientInfoIn**](RecipientInfoIn.md)|  | 

### Return type

[**RecipientInfoOut**](RecipientInfoOut.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **update_payout_methods**
> RecipientPayoutMethods update_payout_methods(recipient_id, body)



create recipient payout methods

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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | R-XXXXXXXXXXXXXXXX

body = SwaggerClient::RecipientPayoutMethods.new # RecipientPayoutMethods | 


begin
  result = api_instance.update_payout_methods(recipient_id, body)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->update_payout_methods: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**| R-XXXXXXXXXXXXXXXX | 
 **body** | [**RecipientPayoutMethods**](RecipientPayoutMethods.md)|  | 

### Return type

[**RecipientPayoutMethods**](RecipientPayoutMethods.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **update_paypal_account**
> PaypalAccount update_paypal_account(recipient_id, body)



create paypal account

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

api_instance = SwaggerClient::RecipientApi.new

recipient_id = "recipient_id_example" # String | 

body = SwaggerClient::PaypalAccount.new # PaypalAccount | paypal payout account


begin
  result = api_instance.update_paypal_account(recipient_id, body)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientApi->update_paypal_account: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipient_id** | **String**|  | 
 **body** | [**PaypalAccount**](PaypalAccount.md)| paypal payout account | 

### Return type

[**PaypalAccount**](PaypalAccount.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined




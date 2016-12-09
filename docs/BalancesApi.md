# SwaggerClient::BalancesApi

All URIs are relative to *http://local.dev:3000/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_paymentrails**](BalancesApi.md#get_paymentrails) | **GET** /v1/profile/balances/paymentrails | 
[**get_paypal**](BalancesApi.md#get_paypal) | **GET** /v1/profile/balances/paypal | 
[**query**](BalancesApi.md#query) | **GET** /v1/profile/balances | 


# **get_paymentrails**
> Balance get_paymentrails



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

api_instance = SwaggerClient::BalancesApi.new

begin
  result = api_instance.get_paymentrails
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling BalancesApi->get_paymentrails: #{e}"
end
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Balance**](Balance.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **get_paypal**
> Balance get_paypal



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

api_instance = SwaggerClient::BalancesApi.new

begin
  result = api_instance.get_paypal
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling BalancesApi->get_paypal: #{e}"
end
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Balance**](Balance.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **query**
> Array&lt;Balance&gt; query



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

api_instance = SwaggerClient::BalancesApi.new

begin
  result = api_instance.query
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling BalancesApi->query: #{e}"
end
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Array&lt;Balance&gt;**](Balance.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined




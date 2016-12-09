# SwaggerClient::BatchApi

All URIs are relative to *http://local.dev:3000/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get**](BatchApi.md#get) | **GET** /v1/batches/{batchId} | 
[**start_processing**](BatchApi.md#start_processing) | **POST** /v1/batches/{batchId}/start-processing | 
[**update**](BatchApi.md#update) | **PATCH** /v1/batches/{batchId} | 


# **get**
> Batch get(batch_id)



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

api_instance = SwaggerClient::BatchApi.new

batch_id = "batch_id_example" # String | B-XXXXXXXXXXXXXXXX


begin
  result = api_instance.get(batch_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling BatchApi->get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **batch_id** | **String**| B-XXXXXXXXXXXXXXXX | 

### Return type

[**Batch**](Batch.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **start_processing**
> Batch start_processing(batch_id)



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

api_instance = SwaggerClient::BatchApi.new

batch_id = "batch_id_example" # String | P-XXXXXXXXXXXXX


begin
  result = api_instance.start_processing(batch_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling BatchApi->start_processing: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **batch_id** | **String**| P-XXXXXXXXXXXXX | 

### Return type

[**Batch**](Batch.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **update**
> update(batch_id, body)



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

api_instance = SwaggerClient::BatchApi.new

batch_id = "batch_id_example" # String | B-XXXXXXXXXXXXXXXX

body = SwaggerClient::BatchUpdate.new # BatchUpdate | 


begin
  api_instance.update(batch_id, body)
rescue SwaggerClient::ApiError => e
  puts "Exception when calling BatchApi->update: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **batch_id** | **String**| B-XXXXXXXXXXXXXXXX | 
 **body** | [**BatchUpdate**](BatchUpdate.md)|  | 

### Return type

nil (empty response body)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined




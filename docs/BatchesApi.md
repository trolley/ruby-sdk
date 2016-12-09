# SwaggerClient::BatchesApi

All URIs are relative to *http://local.dev:3000/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create**](BatchesApi.md#create) | **POST** /v1/batches | 
[**query**](BatchesApi.md#query) | **GET** /v1/batches | 


# **create**
> Batch create(body)



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

api_instance = SwaggerClient::BatchesApi.new

body = SwaggerClient::BatchPost.new # BatchPost | B-XXXXXXXXXXXXXXXX


begin
  result = api_instance.create(body)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling BatchesApi->create: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**BatchPost**](BatchPost.md)| B-XXXXXXXXXXXXXXXX | 

### Return type

[**Batch**](Batch.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **query**
> InlineResponse200 query(opts)



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

api_instance = SwaggerClient::BatchesApi.new

opts = { 
  start_date: "start_date_example", # String | 
  end_date: "end_date_example", # String | 
  status: "status_example" # String | filter one or more status. multiple value comma separated
}

begin
  result = api_instance.query(opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling BatchesApi->query: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **start_date** | **String**|  | [optional] 
 **end_date** | **String**|  | [optional] 
 **status** | **String**| filter one or more status. multiple value comma separated | [optional] 

### Return type

[**InlineResponse200**](InlineResponse200.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined




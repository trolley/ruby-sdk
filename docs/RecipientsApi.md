# SwaggerClient::RecipientsApi

All URIs are relative to *http://local.dev:3000/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create**](RecipientsApi.md#create) | **POST** /v1/recipients | 
[**delete**](RecipientsApi.md#delete) | **DELETE** /v1/recipients | 
[**export_csv**](RecipientsApi.md#export_csv) | **GET** /v1/recipients/exports.csv | 
[**query**](RecipientsApi.md#query) | **GET** /v1/recipients | 
[**upload_csv**](RecipientsApi.md#upload_csv) | **POST** /v1/recipients/upload | 


# **create**
> Recipient create(opts)



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

api_instance = SwaggerClient::RecipientsApi.new

opts = { 
  body: SwaggerClient::RecipientPost.new # RecipientPost | 
}

begin
  result = api_instance.create(opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientsApi->create: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**RecipientPost**](RecipientPost.md)|  | [optional] 

### Return type

[**Recipient**](Recipient.md)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **delete**
> delete(opts)



Delete multiple recipients

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

api_instance = SwaggerClient::RecipientsApi.new

opts = { 
  ids: SwaggerClient::Ids.new # Ids | an array of valid recipient's id
}

begin
  api_instance.delete(opts)
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientsApi->delete: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ids** | [**Ids**](Ids.md)| an array of valid recipient&#39;s id | [optional] 

### Return type

nil (empty response body)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **export_csv**
> export_csv(opts)



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

api_instance = SwaggerClient::RecipientsApi.new

opts = { 
  page: 56, # Integer | page number default 1
  page_size: 56, # Integer | page size default 100
  start_date: "start_date_example", # String | filter recipients list by creation date from start date format YYYY-MM-DD
  end_date: "end_date_example", # String | filter recipients list by creation date to end date format YYYY-MM-DD
  status: "status_example", # String | filter recipients list by status
  compliance_status: "compliance_status_example", # String | filter recipients list by compliance status
  payout_method: "payout_method_example", # String | filter recipients list by payout methods
  payout_currency: "payout_currency_example", # String | filter recipients list by payout currency 3 letters ISO code
  country: "country_example" # String | filter recipients list by country
}

begin
  api_instance.export_csv(opts)
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientsApi->export_csv: #{e}"
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
 **compliance_status** | **String**| filter recipients list by compliance status | [optional] 
 **payout_method** | **String**| filter recipients list by payout methods | [optional] 
 **payout_currency** | **String**| filter recipients list by payout currency 3 letters ISO code | [optional] 
 **country** | **String**| filter recipients list by country | [optional] 

### Return type

nil (empty response body)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: text/csv



# **query**
> Object query(opts)



Return recipients

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

api_instance = SwaggerClient::RecipientsApi.new

opts = { 
  page: 56, # Integer | page number default 1
  page_size: 56, # Integer | page size default 100
  start_date: "start_date_example", # String | filter recipients list by creation date from start date format YYYY-MM-DD
  end_date: "end_date_example", # String | filter recipients list by creation date to end date format YYYY-MM-DD
  status: "status_example", # String | filter recipients list by status multiple values separated by coma
  compliance_status: "compliance_status_example", # String | filter recipients list by compliance status multiple values separated by comas
  payout_method: "payout_method_example", # String | filter recipients list by payout methods multiple values separated by comas
  payout_currency: "payout_currency_example", # String | filter recipients list by payout currency 3 letters ISO code, multiple values separated by comas
  country: "country_example" # String | filter recipients list by country multiple values separated by comas
}

begin
  result = api_instance.query(opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientsApi->query: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **Integer**| page number default 1 | [optional] 
 **page_size** | **Integer**| page size default 100 | [optional] 
 **start_date** | **String**| filter recipients list by creation date from start date format YYYY-MM-DD | [optional] 
 **end_date** | **String**| filter recipients list by creation date to end date format YYYY-MM-DD | [optional] 
 **status** | **String**| filter recipients list by status multiple values separated by coma | [optional] 
 **compliance_status** | **String**| filter recipients list by compliance status multiple values separated by comas | [optional] 
 **payout_method** | **String**| filter recipients list by payout methods multiple values separated by comas | [optional] 
 **payout_currency** | **String**| filter recipients list by payout currency 3 letters ISO code, multiple values separated by comas | [optional] 
 **country** | **String**| filter recipients list by country multiple values separated by comas | [optional] 

### Return type

**Object**

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined



# **upload_csv**
> upload_csv(file)



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

api_instance = SwaggerClient::RecipientsApi.new

file = File.new("/path/to/file.txt") # File | the csv file


begin
  api_instance.upload_csv(file)
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RecipientsApi->upload_csv: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **File**| the csv file | 

### Return type

nil (empty response body)

### Authorization

[merchantKey](../README.md#merchantKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined




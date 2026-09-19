require_relative '../Client'
require 'json'
require 'ostruct'
require 'uri'

module Trolley
  class PartnerGateway
    def initialize(client)
      @client = client
    end

    def get_fees(currency = nil)
      path = '/v1/fees'
      path = "#{path}?#{URI.encode_www_form(currency: currency)}" unless currency.nil?
      parse_response(@client.get(path))
    end

    def update_fees(body)
      parse_response(@client.patch('/v1/fees', body))
    end

    def list_payout_methods
      parse_response(@client.get('/v1/payout-methods'))
    end

    def get_payout_method(payout_method)
      parse_response(@client.get("/v1/payout-methods/#{payout_method}"))
    end

    def update_payout_method(payout_method, body)
      parse_response(@client.patch("/v1/payout-methods/#{payout_method}", body))
    end

    def get_processing_settings
      parse_response(@client.get('/v1/processing-settings'))
    end

    def update_processing_settings(body)
      parse_response(@client.patch('/v1/processing-settings', body))
    end

    def get_white_label_dns_records
      parse_response(@client.get('/v1/white-label/dns-records'))
    end

    def verify_white_label_dns_records
      parse_response(@client.post('/v1/white-label/dns-records/verify', {}))
    end

    def delete_white_label_email
      parse_response(@client.delete('/v1/white-label/email'))
    end

    def update_white_label_icon(body)
      parse_response(@client.patch('/v1/white-label/icon', body))
    end

    def get_white_label_settings
      parse_response(@client.get('/v1/white-label'))
    end

    def update_white_label_settings(body)
      parse_response(@client.patch('/v1/white-label', body))
    end

    def get_widget_configuration
      parse_response(@client.get('/v1/iframe/config'))
    end

    def update_widget_configuration(body = {})
      parse_response(@client.post('/v1/iframe/config', body))
    end

    private

    def parse_response(response)
      return nil if response.nil? || response.empty?

      JSON.parse(response, object_class: OpenStruct)
    end
  end
end

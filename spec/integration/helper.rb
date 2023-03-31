require 'dotenv/load'
require_relative '../../lib/paymentrails'
require 'test/unit'
require 'securerandom'

def uuid
  SecureRandom.uuid.to_s
end

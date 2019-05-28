$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = "paymentrails"
  s.summary = "PaymentRails Ruby SDK"
  s.description = "Ruby SDK for interacting with the PaymentRails API"
  s.version = '0.1.2'
  s.homepage = 'https://www.paymentrails.com/'
  s.email = ['jesse.silber@paymentrails.com', 'joshua@paymentrails.com']
  s.license = "MIT"
  s.author = "PaymentRails"
  s.has_rdoc = false
  s.files = Dir.glob ["README.rdoc", "LICENSE", "lib/**/*.{rb,crt}", "spec/**/*", "*.gemspec"]
  s.add_dependency "rest-client", ">= 2.0.0"
end

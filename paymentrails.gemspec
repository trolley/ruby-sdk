$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = "paymentrails"
  s.summary = "PaymentRails Ruby SDK"
  s.description = "Ruby SDK for interacting with the PaymentRails API"
  s.version = '0.2.1'
  s.homepage = 'https://www.paymentrails.com/'
  s.email = ['joshua@paymentrails.com']
  s.license = "MIT"
  s.author = "PaymentRails"
  s.files = Dir.glob ["README.rdoc", "LICENSE", "lib/**/*.{rb,crt}", "spec/**/*", "*.gemspec"]
  s.add_dependency "rest-client", ">= 2.0.0"
  s.add_development_dependency "rubocop", '~> 0.77'
end

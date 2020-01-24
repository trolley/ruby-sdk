$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = "paymentrails"
  s.summary = "PaymentRails Ruby SDK"
  s.description = "Ruby SDK for interacting with the PaymentRails API"
  s.version = '0.2.3'
  s.homepage = 'https://www.paymentrails.com/'
  s.email = ['joshua@paymentrails.com']
  s.license = "MIT"
  s.author = "PaymentRails"
  s.files = Dir.glob ["README.rdoc", "LICENSE", "lib/**/*.{rb,crt}", "spec/**/*", "*.gemspec"]
  s.required_ruby_version = '>= 2.4'
  s.add_development_dependency 'dotenv', '~> 2'
  s.add_development_dependency 'rake', '~> 12'
  s.add_development_dependency "rubocop", '~> 0.77'
  s.add_development_dependency 'test-unit', '~> 3'
end

$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = "paymentrails"
  s.summary = "Trolley Ruby SDK"
  s.description = "Ruby SDK for interacting with the Trolley API"
  s.version = '0.3.0'
  s.homepage = 'https://trolley.com/'
  s.email = ['developer-tools@trolley.com']
  s.license = "MIT"
  s.author = "PaymentRails"
  s.files = Dir.glob ["README.rdoc", "LICENSE", "lib/**/*.{rb,crt}", "spec/**/*", "*.gemspec"]
  s.required_ruby_version = '>= 2.7'
  s.add_development_dependency 'dotenv', '~> 2'
  s.add_development_dependency 'rake', '~> 12'
  s.add_development_dependency "rubocop", '~> 0.77.0'
  s.add_development_dependency 'test-unit', '~> 3'
end

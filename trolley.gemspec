$:.push File.expand_path('lib', __dir__)

Gem::Specification.new do |s|
  s.name = 'trolley'
  s.summary = 'Trolley Ruby SDK'
  s.description = 'Ruby SDK for interacting with the Trolley API'
  s.version = '1.1.0'
  s.homepage = "https://github.com/trolley/ruby-sdk"
  s.email = ['developer-tools@trolley.com']
  s.license = 'MIT'
  s.authors = ['Trolley']
  s.files = Dir.glob ['README.rdoc', 'LICENSE', 'lib/**/*.{rb,crt}', 'test/**/*', '*.gemspec']
  s.required_ruby_version = '>= 3.2.2'
  s.add_development_dependency 'dotenv', '~> 2'
  s.add_development_dependency 'rake', '~> 13'
  s.add_development_dependency 'rubocop', '~> 1'
  s.add_development_dependency 'test-unit', '~> 3'
  s.add_development_dependency 'vcr', '~> 6.2'
  s.add_development_dependency 'webmock', '~> 3.18'
  s.metadata = {
    "bug_tracker_uri" => "https://github.com/trolley/ruby-sdk/issues",
    "changelog_uri" => "https://github.com/trolley/ruby-sdk/releases",
    "documentation_uri" => "https://docs.trolley.com",
    "homepage_uri" => "https://github.com/trolley/ruby-sdk/",
    "source_code_uri" => "https://github.com/trolley/ruby-sdk.git"
  }
end

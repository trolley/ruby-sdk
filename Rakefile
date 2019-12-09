require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:unit_tests) do |t|
  t.libs << 'lib'
  t.test_files = FileList['spec/unit/*Test.rb']
end

Rake::TestTask.new(:integration_tests) do |t|
  t.libs << 'lib'
  t.test_files = FileList['spec/integration/*Test.rb']
end

Rake::TestTask.new(:tests) do |t|
  t.libs << 'lib'
  t.test_files = FileList['spec/**/*Test.rb']
end

task default: :tests

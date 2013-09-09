require "bundler/gem_tasks"
require "rake/testtask"

ENV["RUBYOPT"] = "rubygems" if ENV["RUBYOPT"].nil?

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test

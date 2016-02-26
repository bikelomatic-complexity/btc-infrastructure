#!/usr/bin/env rake

require 'bundler/setup'
require 'knife_cookbook_doc/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'
require 'kitchen'

namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef)
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

desc 'Create README.md for this cookbook'
task :doc do
  KnifeCookbookDoc::RakeTask.new(:doc) do |t|
    t.options[:output_file] = 'README.md'
  end
end

namespace :integration do
  travis = ENV['TRAVIS'] == 'true'
  pull = ENV['TRAVIS_PULL_REQUEST'] != 'false'
  not_ignore = ENV['IGNORE_TEST_KITCHEN'] != 'true'

  run_kitchen = travis && pull && not_ignore

  desc 'Test the cookbook with test kitchen on EC2'
  task :test do
    if run_kitchen
      `cp .kitchen.cloud.yml .kitchen.local.yml`

      Kitchen.logger = Kitchen.default_file_logger
      Kitchen::Config.new.instances.each do |instance|
        instance.test(:always)
      end
    end
  end

  desc 'Destroy all cloud-based Test Kitchen nodes'
  task :destroy do
    if run_kitchen
      Kitchen.logger = Kitchen.default_file_logger
      Kitchen::Config.new.instances.each(&:destroy)
    end
  end
end

desc 'Build cookbooks-dev.tgz'
task :build do
  `rm -rf cookbooks`
  `bundle exec berks vendor cookbooks`
  `mkdir deploy`
  `tar czf deploy/cookbooks.tgz -C cookbooks .`
end

task travis: %w(style integration:test)

task default: %w(style)

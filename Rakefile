#!/usr/bin/env rake

require 'knife_cookbook_doc/rake_task'
require 'bundler/setup'
require 'rspec/core/rake_task'
# require 'rubocop/rake_task'
require 'foodcritic'
require 'kitchen'

namespace :style do
  # desc 'Run Ruby style checks'
  # RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef)
end

desc 'Run all style checks'
task style: ['style:chef']

desc 'Create README.md for this cookbook'
task :doc do
  KnifeCookbookDoc::RakeTask.new(:doc) do |t|
    t.options[:output_file] = 'README.md'
  end
end

namespace :integration do
  desc 'Run Test Kitchen with Vagrant'
  task :vagrant do
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end

  run_kitchen = false
  if ENV['TRAVIS'] == 'true' && ENV['TRAVIS_PULL_REQUEST'] != 'false' && ENV['IGNORE_TEST_KITCHEN'] != 'true'
    run_kitchen = true
  end

  desc 'Run Test Kitchen with cloud plugins'
  task :cloud do
    if run_kitchen
      Kitchen.logger = Kitchen.default_file_logger
      @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.cloud.yml')
      config = Kitchen::Config.new(loader: @loader)
      config.instances.each do |instance|
        instance.test(:always)
      end
    end
  end

  desc 'Destroy all cloud-based Test Kitchen nodes'
  task :cloud_destroy do
    if run_kitchen
      Kitchen.logger = Kitchen.default_file_logger
      @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.cloud.yml')
      config = Kitchen::Config.new(loader: @loader)
      config.instances.each do |instance|
        instance.destroy
      end
    end
  end
end

desc 'Run all tests on Travis'
task travis: %w(style integration:cloud)

# Default
task default: %w(style)

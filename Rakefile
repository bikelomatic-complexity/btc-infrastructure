#!/usr/bin/env rake

require 'bundler/setup'
require 'knife_cookbook_doc/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'

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

desc 'Run Test Kitchen with cloud plugins'
task :integration do
  travis = ENV['TRAVIS'] == 'true'
  pull = ENV['TRAVIS_PULL_REQUEST'] != 'false'
  not_ignore = ENV['IGNORE_TEST_KITCHEN'] != 'true'

  if travis && pull && not_ignore
    `cp .kitchen.cloud.yml .kitchen.local.yml`
    `kitchen test --destroy=always`
  end
end

task travis: %w(style integration)

# Default
task default: %w(style)

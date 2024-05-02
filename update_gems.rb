#!/usr/bin/env ruby

# In this script, the check_versions function is added, which uses the 'bundle outdated' command to get a list of outdated gems. 
# If there are outdated gems, they are printed on the console. 
# Otherwise, a message is displayed that all gems are up to date.

require 'bundler/cli'
require 'highline'

cli = HighLine.new

def update_gems
  Bundler::CLI.start(['update'])
rescue Bundler::BundlerError => e
  puts "An error occurred while updating the gems: #{e.message}"
rescue => e
  puts "An unexpected error occurred: #{e.message}"
end

def list_outdated
  Bundler::CLI.start(['outdated'])
rescue Bundler::BundlerError => e
  puts "An error occurred while listing the outdated gems: #{e.message}"
rescue => e
  puts "An unexpected error occurred: #{e.message}"
end

def check_versions
  outdated_gems = `bundle outdated`
  if outdated_gems.empty?
    puts "All gems are up to date."
  else
    puts "The following gems have newer versions available:"
    puts outdated_gems
  end
end

begin
  check_versions
  answer = cli.ask "Do you want to update all outdated gems? (y/n) "
  if answer.downcase == 'y'
    update_gems
  end
rescue HighLine::InvalidCharacter => e
  puts "Invalid input: #{e.message}"
rescue => e
  puts "An unexpected error occurred: #{e.message}"
end
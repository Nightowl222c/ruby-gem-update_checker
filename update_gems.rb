#!/usr/bin/env ruby

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

begin
  list_outdated
  answer = cli.ask "Do you want to update all outdated gems? (y/n) "
  if answer.downcase == 'y'
    update_gems
  end
rescue HighLine::InvalidCharacter => e
  puts "Invalid input: #{e.message}"
rescue => e
  puts "An unexpected error occurred: #{e.message}"
end
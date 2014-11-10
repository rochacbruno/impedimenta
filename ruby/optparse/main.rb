#!/usr/bin/env ruby
# Demonstrate how to use optparse. These commands succeed:
#
#     ./main.rb
#     ./main.rb --help
#     ./main.rb --foo
#
# These commands fail:
#
#     ./main.rb foo
#     ./main.rb --bar

require 'optparse'

options = {}
puts "Before argument parsing, ARGV=#{ARGV} and options=#{options}"
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"
  opts.on('-f', '--foo', 'No-op argument.') do |f|
    options[:f] = f
  end
  opts.parse!

  puts "After argument parsing, ARGV=#{ARGV} and options=#{options}"
  # Check for spurious arguments. (parse! removes elements from ARGV.)
  opts.abort("Received spurious arguments: #{ARGV}") if ARGV.length > 0
end

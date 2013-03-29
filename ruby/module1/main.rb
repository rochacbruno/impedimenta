#!/usr/bin/env ruby
# Demonstrates the use of modules as namespaces.

require_relative 'action'
require_relative 'trig'

# Even though PI is only available in one of the two required modules, it must
# be referenced as Trig::PI
puts "pi ~= #{Trig::PI}"

# Module::Constant
# Module.method
puts "Sin of the day: #{Action.sin(Trig.sin(1))}"

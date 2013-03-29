#!/usr/bin/env ruby
# Demonstrates the use of modules as mixins.

require_relative 'classes'
require_relative 'module'

puts EightTrack.new('Legend of the Black Shawarma').whoAmI?
puts Introspect.moduleMethod
puts Introspect::ADVICE

# Fails. Singleton methods cannot be mixed in.
# puts Phonograph.new('Classical Mushroom').moduleMethod

# Fails. Methods must be in a class to be used.
# puts Introspect.whoAmI?

# Fails. A module-level constant can only be accessed from that module.
# puts Phonograph.new('I\'m the Supervisor')::ADVICE

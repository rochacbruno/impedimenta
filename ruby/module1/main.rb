#!/usr/bin/env ruby

# expand_path assumes that it's second argument (in this case, __FILE__) is a
# directory.
require_relative 'action'
require_relative 'trig'

# Even though PI is only available in one of mixed-in modules, it must be
# referenced as Trig::PI
puts "pi ~= #{Trig::PI}"

# Module::Constant
# Module.method
puts Action.sin(Trig.sin(-1))

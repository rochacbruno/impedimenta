# Demonstrates ruby's +load+ and +require+, singleton methods, mixins, dynamic
# class alteration, and reflection.

# Ruby searches the +$LOAD_PATH+, or +$:+, for files to include. Programs may
# modify the load path at runtime. Calling ruby with the -I option (e.g. ruby
# -I . Main.rb) also appends to +$LOAD_PATH+.
require 'tempfile'
require 'Dependencies'

#The loader function demonstrates use of load to repeatedly include a file
#See loader definition for details
puts "Demonstration of `load`"
puts "======================="
loader
puts ""

# Ruby is a duck-typed language: it focuses on methods and "what can X do?",
# rather than classes and "what is X?". To support this philosophy, ruby
# reflection (e.g. respond_to?) and singleton methods (adding a method to a
# single object). Note that a singleton method is *NOT* the same as the
# singleton design pattern.
puts "Demonstration of singleton methods"
puts "=================================="
obj = Class.new
puts "obj.respond_to? foo: #{obj.respond_to? :foo}"
def obj.foo; "kung foo"; end
puts "obj.respond_to? foo: #{obj.respond_to? :foo}"
puts ""

# When you instantiate a class in Ruby, that class's methods are not also
# instantiated. Rather, objects just look for method definitions when needed.
# Thus, when a class's definition changes, all instances of that class are
# affected.
puts "Demonstration of dynamic class alteration"
puts "========================================="
monster = Frankenstein.new
puts monster.greeting
# Now we're going to make Frankenstein evil.
class Frankenstein
	def greeting
		"Hello World, I'm going to destroy you."
	end
end
# This will output the newly defined greeting, despite the fact that monster
# was instantiated before the change was made.
puts monster.greeting
puts ""

# When a module is mixed-in to an object or class, all of that module's instance
# methods are inherited.
puts "Demonstration of mixins"
puts "======================="
philosopher = Class.new.extend(Introspector)
puts philosopher.introspect
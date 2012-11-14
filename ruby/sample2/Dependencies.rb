# Demonstrates some of Ruby's more advanced features. Written by Jeremy Audet
# and Henry Corse, for CIS-3030 (programming languages) with Peter Chapin.

# Ruby has two built-in mechanisms for including code: +load+ and +require+.
# +load+ is the simpler of the two: it requires the full basename (or full path,
# if the file lies outside +$:+) of the file being read, and it has no
# safeguards against reading the same file multiple times. We use that to our
# advantage here by repeatedly writing out code to a file and +load+ing it.
#
# Though using +load+ in the manner shown below is a form of metaprogramming,
# far better tools for the job exist.
#
# +Tempfile+ acts as a thin wrapper around +File+. Any methods that can be
# called on a +File+ object can be called on a +Tempfile+ object.
def loader
    f = Tempfile.new('arbitrary')
    5.times do |num|
        f.rewind
        f.write "" +
            "module Fortune\n"\
            "    def self.message; \"Your lucky number is #{num}!\"; end\n"\
            "end"
        f.truncate(f.pos)
        f.flush
        load f.path
        puts Fortune.message
    end
    f.close
    f.delete
    puts "You can, of course, access loaded modules even after their source "\
        "file has been deleted. For example, Fortune.message returns the "\
        "following string: \"#{Fortune.message}\""
end

# This module provides an instance method for use as a mixin.
#
# Modules in ruby can serve two purposes: namespace separation and method
# mixins. The latter is especially important, as ruby doesn't allow multiple
# inheritance.
module Introspector
    # Ruby has well-fleshed-out support for reflection. This method demonstrates
    # some (though not all!) of the tools available for introspection.
	# +self+, +class+, and +superclass+ all return objects. Thus, you can
	# call +superclass+ on the object returned by +superclass+.
    def introspect
        "Class: #{self.class}\n" +
		"Class superclass: #{self.class.superclass}\n" +
        "Class superclass superclass: #{self.class.superclass.superclass}\n" +
        "Class ancestors: #{self.class.ancestors}\n" +
        "Class included_modules: #{self.class.included_modules}\n" +
        "Is an Object? #{self.is_a? Object}\n" +
        "Instance of Object? #{self.instance_of? Object}\n" +
        # Too much output. Obscures other output, diluting example.
        #"Class instance_methods: #{self.class.instance_methods}\n" +
        "Lexical module nesting: #{Module.nesting}" +
        ""
    end
end

# A trivial class that can return a greeting.
class Frankenstein
    # Returns a string.
	def greeting
		"Hello World."
	end
end
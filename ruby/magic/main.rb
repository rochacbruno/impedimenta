#!/usr/bin/env ruby
# An experiment with +class_eval+ and +instance_eval+.
#
# +class_eval+ makes it as if you are performing method definitions within a
# class definition. Thus, <tt>def foo</tt> becomes an instance method, and
# <tt>def self.foo</tt> becomes a class method.
#
# +instance_eval+ makes as if you are performing method definitions within an
# object's eigenclass (i.e. singleton class, anonymous class). Thus, both
# <tt>def foo</tt> and <tt>def self.foo</tt> become eigenclass class methods.
# (right??)
#
# See: http://stackoverflow.com/questions/4409023/rubys-def-and-instance-eval-vs-class-eval
# See: http://www.devalot.com/articles/2008/09/ruby-singleton
# See: http://ruby-metaprogramming.rubylearning.com/html/ruby_metaprogramming_1.html

# class_eval and instance_eval on a class --------------------------------------

class A
end

A.class_eval do
    def foo; 'foo'; end
end
puts(A.new.foo)

A.class_eval do
    def self.bar; 'bar'; end
end
puts(A.bar)

A.instance_eval do
    def biz; 'biz'; end
end
puts(A.biz)

A.instance_eval do
    def self.baz; 'baz'; end
end
puts(A.baz)

puts("class methods: #{A.singleton_methods}") # => [:bar, :biz, :baz]
puts("instance methods: #{A.new.singleton_methods}") # => []

# class_eval and instance_eval on an instance ----------------------------------

class B
end
b = B.new

#b.class_eval do
#    def foo; 'foo'; end
#end

#b.class_eval do
#    def self.bar; 'bar'; end
#end

b.instance_eval do
    def biz; 'biz'; end
end
puts(b.biz)

b.instance_eval do
    def self.baz; 'baz'; end
end
puts(b.baz)

puts("class methods: #{B.singleton_methods}") # => []
puts("instance methods: #{b.singleton_methods}") # => [:biz, :baz]

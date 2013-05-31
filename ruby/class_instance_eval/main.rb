#!/usr/bin/env ruby
# An experiment with +class_eval+ and +instance_eval+.
#
# See also:
# * http://stackoverflow.com/questions/4409023/rubys-def-and-instance-eval-vs-class-eval
# * http://www.devalot.com/articles/2008/09/ruby-singleton
# * http://ruby-metaprogramming.rubylearning.com/html/ruby_metaprogramming_1.html

# class_eval -------------------------------------------------------------------

class A
end
a = A.new

A.class_eval do
    def foo
    end
end

A.class_eval do
    def self.bar
    end
end

#a.class_eval do # NoMethodError
#    def biz
#    end
#end

#a.class_eval do # NoMethodError
#    def self.baz
#    end
#end

puts('class_eval')
puts("- class methods: #{A.singleton_methods}") # => [:bar]
puts("- instance methods: #{
    [:foo, :bar, :biz, :baz].collect {
        |name| A.new.respond_to?(name) ? name : nil
    }.compact
}") # => [:foo]
puts("- singleton methods: #{a.singleton_methods}") # => []

# instance_eval ----------------------------------------------------------------

class B
end
b = B.new

B.instance_eval do
    def foo
    end
end

B.instance_eval do
    def self.bar
    end
end

b.instance_eval do
    def biz
    end
end
#puts(b.respond_to? :biz) # => true

b.instance_eval do
    def self.baz
    end
end
#puts(b.respond_to? :baz) # => true

puts('instance_eval')
puts("- class methods: #{B.singleton_methods}") # => [:foo, :bar]
puts("- instance methods: #{
    [:foo, :bar, :biz, :baz].collect {
        |name| B.new.respond_to?(name) ? name : nil
    }.compact
}") # => []
puts("- singleton methods: #{b.singleton_methods}") # => [:biz, :baz]

#!/usr/bin/env ruby
#
# About
# =====
#
# Demonstrates how to declare and instantiate classes, and how to modify objects
# at runtime. This script focuses more on showing off features than doing
# anything useful.
#

class VerbosePoint
    # constructor
    def initialize(x, y)
        @x, @y = x, y
    end

    # accessor, but not mutator
    def x
        @x
    end

    # accessor, but not mutator
    def y
        @y
    end

    # to string
    def to_s
        "(#{@x},#{@y})"
    end

    # class method
    def VerbosePoint.classMethod
    end

# by default, methods are public
#protected   # following are protected
#private     # following are private
#public      # following are public
end

class CompactPoint
    def initialize(x, y)
        @x, @y = x, y
    end

    attr_reader(:x, :y)

    def to_s
        "(#@x,#@y)"
    end

    def self.classMethod
    end
end

# OK, done making definitions. Do something with them!
point1 = VerbosePoint.new(1, 2)
point2 = CompactPoint.new(2, 3)
# can this be looped?
puts "point1"
puts "    ID: #{point1.object_id}"
puts "    value: #{point1.to_s}"
puts "point2"
puts "    ID: #{point2.object_id}"
puts "    value: #{point2}"

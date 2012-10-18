#!/usr/bin/env ruby
#
# About
# =====
#
# Demonstrates some basic facts about Ruby classes. This script focuses more on
# showing off features than doing anything useful. This is largely ripped from
# "The Ruby Programming Language", by David Flanagan.
#

# By default, methods are public. You can change them explicitly like shown
# below, or you can place the keywords in the class definition a la C++. ::
#
#    public     :initialize, :to_s
#    protected
#    private    :x, :y

class Point
    @@num_points = 0

    def initialize(x, y)
        @x, @y = x, y
        @@num_points += 1
    end

    # cannot occur before initialize
    attr_reader(:x, :y)
    # alternately:
    # def x; @x; end
    # def y; @y; end

    ORIGIN = self.new(0, 0)

    def to_s
        "(#@x,#@y)" # note: no curly braces for single var substitution
    end

    # vector addition
    def +(other)
        # Must explicitly prefix new with ``Point.``, because not class method.
        Point.new(@x + other.x, @y + other.y)
    end

    # Class method. Alternately: def Point.num_points; @@num_points; end
    def self.num_points
        @@num_points
    end

    # add an arbitrary number of ``Point``s
    def self.sum(*points)
        x = y = 0
        points.each { |point|
            x += point.x
            y += point.y
        }
        self.new(x, y)
    end
end

# OK, done making definitions. Do something with them!
puts "point: #{point = Point.new(1, 2)}"
puts "object_id: #{point.object_id}"
puts "to_s: #{point}"
puts "#{point} + #{point}: #{point + point}"
puts "Point.sum(%s, %s, %s): %s" %
      [point, point, point, Point.sum(point, point, point)]
puts "Point.num_points: #{Point.num_points}"
puts "Point::ORIGIN: #{Point::ORIGIN}"

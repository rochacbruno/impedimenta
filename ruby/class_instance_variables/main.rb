#!/usr/bin/env ruby

class BaseClass
    @word = 'base'

    def BaseClass.word=(word)
        @word = word
    end

    def BaseClass.word
        @word
    end
end

class SubClass < BaseClass
    @word = 'sub'
end

puts('class instance variables can be touched by instance methods')
puts("BaseClass.word => #{BaseClass.word}")

puts('class instance variables are not inherited, but singleton methods are')
puts("SubClass.word => #{SubClass.word}")
puts("BaseClass.word => #{BaseClass.word}")

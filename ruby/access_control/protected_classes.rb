#!/usr/bin/env ruby
# From: http://rubylearning.com/satishtalim/ruby_access_control.html

class Person
    def initialize(age)
        @age = age
    end

    def age; @age; end

    def compare_age(person)
        if person.age > self.age # Permitted by `protected`.
            "The other object's age is bigger."
        else
            "The other object's age is the same or smaller."
        end
    end

    protected(:age)
end

alice = Person.new(25)
bob = Person.new(34)
puts alice.compare_age(bob)
#puts alice.age # Forbidden by `protected`.

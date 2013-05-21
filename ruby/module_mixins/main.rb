#!/usr/bin/env ruby

module Parent
    def word
        "word"
    end
end

module Child
    include Parent
    def bigger_word
        "bigger #{word}"
    end
end

class User
    include Child
end

puts('Modules can use mixed-in instance modules.')
puts(User.new.word)
puts(User.new.bigger_word)

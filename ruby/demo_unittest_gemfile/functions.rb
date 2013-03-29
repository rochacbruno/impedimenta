#!/usr/bin/env ruby

# Accepts a String and rearranges all the words in ascending order, by length.
# Returns a new String. The only word separators are spaces. For example, given
# the string Given a string "Sort the words in a sentence", it should return "a
# in the Sort words sentence".
def sort_string(string)
    words = string.split
    # insertion sort, from left to right
    0.upto(words.length - 2) do |i|
        i.downto(0) do |j|
            if(words[j].length > words[j + 1].length)
                temp = words[j]
                words[j] = words[j + 1]
                words[j + 1] = temp
            else
                break
            end
        end
    end
    words.join ' '
end

# Does the exact same thing as +sort_string+.
def sort_string_2(string)
    string.split.sort{|left, right|
        left.length <=> right.length
    }.join(' ')
end

#!/usr/bin/env ruby

module M
    def call_methods
        #self.meth1 # Forbidden by `private`.
        meth
    end

    def meth; 'meth'; end

    private(:meth)
end

class A
    include M
end

puts('Classes can call private, mixed-in methods.')
puts(A.new.call_methods)

class B
    include M

    def meth; 'overridden meth'; end
end

puts('Classes can override private, mixed-in methods.')
puts(B.new.call_methods)

#!/usr/bin/env ruby

class A
    def call_methods
        #self.meth1 # Forbidden by `private`.
        meth
    end

    def meth; 'meth'; end

    private(:meth)
end

puts('Classes can call private, inherited methods.')
puts(A.new.call_methods)

class B < A
    def meth; 'overridden meth'; end
end

puts('Classes can override private, inherited methods.')
puts(B.new.call_methods)

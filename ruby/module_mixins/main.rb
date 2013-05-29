#!/usr/bin/env ruby

module ParentModule
    def meth
        'method'
    end
end

module ChildModule
    include ParentModule
    def wrap_meth
        "wrapped #{meth}"
    end
end

class ReceivingClass
    include ChildModule
end

class OverridingReceivingClass
    include ChildModule
    def meth
        'overridden ' + super
    end
end

puts('Classes can use instance methods from mixed-in modules.')
puts('- ' + ReceivingClass.new.meth)
puts('- ' + ReceivingClass.new.wrap_meth)
puts('Definitions are looked-up dynamically.')
puts('- ' + OverridingReceivingClass.new.meth)
puts('- ' + OverridingReceivingClass.new.wrap_meth)

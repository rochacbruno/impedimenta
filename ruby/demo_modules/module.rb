module Introspect
    ADVICE = 'Don\'t forget your towel!'

    # This is a method which can be mixed in.
    def whoAmI?
        "#{self.class} (#{self.object_id}): #{self.to_s}"
    end

    # This is a singleton method which cannot be mixed in.
    def Introspect.moduleMethod
        'This string was spat out by a module method.'
    end
end

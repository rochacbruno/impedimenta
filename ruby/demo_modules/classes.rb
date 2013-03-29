# You need to drag a module into the current file before it can be included by
# classes as a mixin.
require_relative 'module'

class Phonograph
    include Introspect

    def initialize(albumName)
        @albumName = albumName
    end

    def to_s
        @albumName
    end
end

class EightTrack
    include Introspect

    def initialize(albumName)
        @albumName = albumName
    end

    def to_s
        @albumName
    end
end

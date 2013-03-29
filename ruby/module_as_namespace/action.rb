module Action
    BAD = 0
    VERY_BAD = 1

    def Action.sin(badness)
        case badness
            when BAD
                "name variables badly"
            when VERY_BAD
                "write incorrect comments"
            else
                "use APL"
            end
    end
end

module Action
    BAD = 0
    VERY_BAD = 1

    def Action.sin(badness)
        punishment = case badness
            when BAD
                "five Hail Marys"
            when VERY_BAD
                "purgatory"
            else
                "excommunication"
            end
        "Thine punishment is: #{punishment}"
    end
end

#!/bin/bash
# Jeremy Audet
# 04/28/2011

#======================================\
# Variable and constant declarations.
#======================================/
# 1 mph = 1.609344 kph
# mph * CONVERT= kph
# kph / CONVERT= mph
declare -r CONVERT=1.609344 # -r means read-only. i.e. this is a constant
user_in="";

#======================================\
# function mph_to_kph
#======================================/
function mph_to_kph {
    echo "Enter a speed in MPH."
    echo -n "> "
    read user_in

    echo ""
    if is_integer "$user_in"; then
        echo -n "Speed in KPH is: "
        echo "$user_in * $CONVERT" | bc -l  # bash can only do integer math
    else
        echo "Invalid input: $user_in"
        echo "Input must be an integer."
    fi
    echo ""
}

#======================================\
# function kph_to_mph
#======================================/
function kph_to_mph {
    echo "Enter a speed in KPH."
    echo -n "> "
    read user_in

    echo ""
    if is_integer "$user_in"; then
        echo -n "Speed in MPH is: "
        echo "$user_in / $CONVERT" | bc -l
    else
        echo "Invalid input: $user_in"
        echo "Input must be an integer."
    fi
    echo ""
}

#======================================\
# function is_integer
#======================================/
function is_integer {
    if [ "$1" -eq "$1" 2>/dev/null ]; then
        return 0
    else
        return 1
    fi
}

#======================================\
# Main
#======================================/
while true; do
    echo "Welcome to the best conversion utility ever!"
    echo "1) Convert MPH to KPH"
    echo "2) Convert KPH to MPH"
    echo "3) Quit"
    echo -n "> "
    read user_in

    if [ "1" == "$user_in" ]; then
        mph_to_kph
    elif [ "2" == "$user_in" ]; then
        kph_to_mph
    elif [ "3" == "$user_in" ]; then
        echo ""
        echo "Thank you, please come again."
        echo ""
        exit 0
    else
        echo ""
        echo "Invalid input: $user_in"
        echo "Valid inputs are '1', '2', and '3'."
        echo ""
    fi
done

exit 0  # should never reach this line

#!/bin/bash
# Jeremy Audet
# 05/6/2011

#======================================\
# Variable and constant declarations.
#======================================/
mass_kg="";
height_cm="";
bmi=0;
calc_again=0;
menu_opts="yes no";

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
while [ 0 -eq $calc_again ]; do # 1 == false, 0 == true
    echo "Welcome to the best BMI calculator ever!"

    # get mass
    echo "Enter your mass in kilograms."
    echo -n "> "
    read mass_kg
    is_integer "$mass_kg"
    while [ 0 != $? ]; do
        echo "I need a number, like 220."
        echo "Enter your mass in kilograms."
        echo -n "> "
        read mass_kg
        is_integer "$mass_kg"
    done
    echo ""

    # get height
    echo "Enter your height in centimeters."
    echo -n "> "
    read height_cm
    is_integer "$height_cm"
    while [ 0 != $? ]; do
        echo "I need a number, like 180."
        echo "Enter your height in centimeters."
        echo -n "> "
        read height_cm
        is_integer "$height_cm"
    done
    echo ""

    # calculate BMI and display to user
    bmi=$(echo "scale=0; ($mass_kg / (($height_cm * $height_cm) / 10000))" | bc -l)
    if [ "$bmi" -lt "18" ]; then
        echo "Your BMI is $bmi."
        echo "That's a bit low; eat something!"
    elif [ "$bmi" -gt "25" ]; then
        echo "Your BMI is $bmi."
        echo "That's a bit high. Time to start slimmin down!"
    else
        echo "Your BMI is $bmi."
        echo "Perfect!"
    fi

    # do it again?
    echo "Calculate another BMI?";
    select user_in in $menu_opts; do
        if [ "yes" = "$user_in" ]; then
            let calc_again=0;   # 0 == true
            echo ""
            break
        fi

        if [ "no" = "$user_in" ]; then
            let calc_again=1;   # 1 == false
            break
        fi
    done
done

exit 0

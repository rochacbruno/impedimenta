#!/bin/bash

declare -ri TEST_NO_ARG=1
declare -ri TEST_NO_SWITCH=1
declare -ri TEST_SWITCH_d=1
declare -ri TEST_SWITCH_D=1
declare -ri TEST_SWITCH_dD=1

if [ 1 == $TEST_NO_ARG ]; then
    echo '$ perl compare_dates.pl'
    perl compare_dates.pl
    echo '$ perl compare_dates.pl -d'
    perl compare_dates.pl -d
    echo '$ perl compare_dates.pl -D'
    perl compare_dates.pl -D
    echo '$ perl compare_dates.pl -dD'
    perl compare_dates.pl -dD
    echo
fi

if [ 1 == $TEST_NO_SWITCH ]; then
    echo '$ perl compare_dates.pl "february 2009" "february 2009"'
    perl compare_dates.pl "february 2009" "february 2009"
    echo '$ perl compare_dates.pl "february 2009" "march 2009"'
    perl compare_dates.pl "february 2009" "march 2009"
    echo '$ perl compare_dates.pl "march 2009" "february 2009"'
    perl compare_dates.pl "march 2009" "february 2009"
    echo
fi

if [ 1 == $TEST_SWITCH_d ]; then
    echo '$ perl compare_dates.pl -d "february 2009" "february 2009"'
    perl compare_dates.pl -d "february 2009" "february 2009"
    echo '$ perl compare_dates.pl -d "february 2009" "march 2009"'
    perl compare_dates.pl -d "february 2009" "march 2009"
    echo '$ perl compare_dates.pl -d "march 2009" "february 2009"'
    perl compare_dates.pl -d "march 2009" "february 2009"
    echo
fi

if [ 1 == $TEST_SWITCH_D ]; then
    echo '$ perl compare_dates.pl -D "february 2009" "february 2009"'
    perl compare_dates.pl -D "february 2009" "february 2009"
    echo '$ perl compare_dates.pl -D "february 2009" "march 2009"'
    perl compare_dates.pl -D "february 2009" "march 2009"
    echo '$ perl compare_dates.pl -D "march 2009" "february 2009"'
    perl compare_dates.pl -D "march 2009" "february 2009"
    echo
fi

if [ 1 == $TEST_SWITCH_dD ]; then
    echo '$ perl compare_dates.pl -dD "february 2009" "february 2009"'
    perl compare_dates.pl -dD "february 2009" "february 2009"
    echo '$ perl compare_dates.pl -dD "february 2009" "march 2009"'
    perl compare_dates.pl -dD "february 2009" "march 2009"
    echo '$ perl compare_dates.pl -dD "march 2009" "february 2009"'
    perl compare_dates.pl -dD "march 2009" "february 2009"
    echo
fi

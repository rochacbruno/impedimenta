#!/usr/bin/perl
use strict;
use warnings;
use feature 'switch';

package Ichi10::StatUtils;

# Summary
#   Returns mean.
# Arguments
#   $_[0] Array ref.
sub mean {
    my $nums = shift;
    my $mean = 0;

    foreach my $num (@$nums) {
        $mean += $num;
    }
    $mean /= scalar(@$nums);

    return $mean;
}

# Summary
#   Returns minimum.
# Arguments
#   $_[0] Array ref.
sub min {
    my $nums = shift;
    my $min  = 0;

    $min = $$nums[0];
    foreach my $num (@$nums) {
        if($num < $min) {
            $min = $num;
        }
    }

    return $min;
}

# Summary
#   Returns maximum.
# Arguments
#   $_[0] Array ref.
sub max {
    my $nums = shift;
    my $max  = 0;

    $max = $$nums[0];
    foreach my $num (@$nums) {
        if($num > $max) {
            $max = $num;
        }
    }

    return $max;
}

# Summary
#   Returns median.
# Arguments
#   $_[0] Array ref.
sub median {
    my $nums    = shift;
    my $median  = 0;
    my @list    = @$nums; # allows for destructive behaviour

    @list = sort {$a <=> $b} @list;

    # if an odd number of values, else an even number of values
    if(1 == scalar(@list) % 2) {
        $median = $list[(scalar(@list) - 1) / 2];
    } else {
        $median = ($list[scalar(@list) / 2] + $list[(scalar(@list) / 2) - 1]) / 2;
    }

    return $median;
}

# Summary
#   Returns first quartile.
# Arguments
#   $_[0] Array ref.
sub q1 {
    my $nums    = shift;
    my $i       = scalar(@$nums);
    my $q1      = 0;
    my @list    = @$nums;

    @list = sort {$a <=> $b} @list;

    given(scalar @list) {
        when(/^0$/) { return '0';           }
        when(/^1$/) { return $list[0]; }
        when(/^2$/) { return $list[0]; }
        when(/^3$/) { return $list[0]; }
        default     {                  } # nothing to see here, move along
    }

    given(scalar(@list) % 4) {
        when(/^0$/) {
            $i /= 2;
            $i /= 2;
            $q1 = ($list[$i] + $list[$i - 1]) / 2;
        }
        when(/^1$/) {
            $i -= 1;
            $i /= 2;
            $i /= 2;
            $q1 = ($list[$i] + $list[$i - 1]) / 2;
        }
        when(/^2$/) {
            $i /= 2;
            $i -= 1;
            $i /= 2;
            $q1 = $list[$i];
        }
        when(/^3$/) {
            $i -= 1;
            $i /= 2;
            $i -= 1;
            $i /= 2;
            $q1 = $list[$i];
        }
        default {
            die "some fucked-up math just happened, and this program needs to die.\n";
        }
    }

    return $q1;
}

# Summary
#   Returns third quartile.
# Arguments
#   $_[0] Array ref.
sub q3 {
    my $nums    = shift;
    my $i       = scalar(@$nums);
    my $q3      = 0;
    my @list    = @$nums;

    @list = sort {$a <=> $b} @list;

    given(scalar @list) {
        when(/^0$/) { return '0';           }
        when(/^1$/) { return $list[0]; }
        when(/^2$/) { return $list[1]; }
        when(/^3$/) { return $list[2]; }
        default     {                  } # nothing to see here, move along
    }

    given(scalar(@list) % 4) {
        when(/^0$/) {
            $i *= 0.75;
            $q3 = ($list[$i] + $list[$i - 1]) / 2;
        }
        when(/^1$/) {
            $i -= 1;
            $i *= 0.75;
            $q3 = ($list[$i] + $list[$i + 1]) / 2;
        }
        when(/^2$/) {
            $i -= ((scalar(@list) + 2) / 4);
            $q3 = $list[$i];
        }
        when(/^3$/) {
            $i -= ((scalar(@list) + 1) / 4);
            $q3 = $list[$i];
        }
        default {
            die "some fucked-up math just happened, and this program needs to die.\n";
        }
    }

    return $q3;
}

# Summary
#   Returns standard deviation of sample.
# Arguments
#   $_[0] Array ref. A sample whose standard deviation is being found.
#   $_[1] Scalar. Mean of the sample.
sub std_dev_sam {
    my $nums    = shift;
    my $mean    = shift;
    my $std_dev = 0;

    foreach my $number (@$nums) {
        $std_dev += ($number - $mean) * ($number - $mean);
    }
    $std_dev = sqrt($std_dev / (scalar(@$nums) - 1));

    return $std_dev;
}

# Summary
#   Returns standard deviation of a population.
# Arguments
#   $_[0] Array ref. A population whose standard deviation is being found.
#   $_[1] Scalar. Mean of the population.
sub std_dev_pop {
    my $nums    = shift;
    my $mean    = shift;
    my $std_dev = 0;

    foreach my $number (@$nums) {
        $std_dev += ($number - $mean) * ($number - $mean);
    }
    $std_dev = sqrt($std_dev / scalar(@$nums));

    return $std_dev;
}

# Summary
#   Returns correlation coefficient of two lists of numbers. Lists of numbers
#   MUST be of equal size. First and second lists are assumed to be explanatory
#   and response variable, respectively. A number in range -1 to 1 should be
#   returned; if not, either an error occurred internally, or a descriptive
#   error message will be retunred.
# Arguments
#   $_[0] Array ref. First list of numbers.
#   $_[1] Array ref. Second list of numbers.
#   $_[2] Scalar. Mean of first list.
#   $_[3] Scalar. Mean of second list.
#   $_[4] Scalar. Standard deviation of first list.
#   $_[5] Scalar. Standard deviation of second list.
sub cor_coeff {
    my $list1       = shift;
    my $list2       = shift;
    my $mean1       = shift;
    my $mean2       = shift;
    my $std_dev1    = shift;
    my $std_dev2    = shift;
    my $size1       = scalar(@$list1);
    my $size2       = scalar(@$list2);
    my $cor_coeffic = 0;

    if($size1 != $size2) {
        warn "list sizes differ, cannot find correlation coefficient ($size1, $size2)\n";
        return 2; # 2 is not a valid correlation coefficient
    } elsif(0 == $size1) {
        warn "cannot find correlation coefficient for list of size zero\n";
        return 2;
    }

    for(my $i = 0; $i < $size1; $i++) {
        $cor_coeffic += ($$list1[$i] - $mean1) * ($$list2[$i] - $mean2);
    }
    $cor_coeffic /= ($size1 * $std_dev1 * $std_dev2);

    return $cor_coeffic;
}

# Summary
#   Given a set of values and the mean of those values, return the total
#   variation from the mean. The set of values passed in will typically be
#   y-values.
# Arguments
#   $_[0] Array ref. A set of values.
#   $_[1] Scalar. The mean of those values.
sub total_var {
    my $vals    = shift;
    my $mean    = shift;
    my $tv      = 0; # total variation

    foreach my $val (@$vals) {
        $tv += (($val - $mean) * ($val - $mean));
    }

    return $tv;
}

# Summary
#   Given a set of x values and y values, and a line, find the unexplained
#   variation of that line from the set of points. The sets of x and y values
#   MUST have the same ordering. That is, $x_vals[$i] and $y_vals[$i] are
#   a single point on a cartesian plane.
# Arguments
#   $_[0] Array ref. A set of x-values.
#   $_[1] Array ref. A set of y-values.
#   $_[2]
#   $_[3]
#       Scalars. The slope and y-intercept of the line for which the
#       unexplained variation is being found (for example, the slope and
#       y-intercept of a least squares regression line).
sub unexplained_var {
    my ($x_vals, $y_vals, $slope, $y_int) = @_;
    my $uv = 0; # unexplained variation

    for (my $i = 0; $i < scalar(@$x_vals); $i++) {
        my $y_hat = $slope * $x_vals->[$i] + $y_int; # expected y value
        $uv += (($y_vals->[$i] - $y_hat) * ($y_vals->[$i] - $y_hat));
    }

    return $uv;
}

# Summary
#   Given the point-slope equation for a line and the mean of a set of y values,
#   find the total explained variation between the two.
# Arguments
#   $_[0] Scalar. Slope of a line
#   $_[0] Array ref. A set of x-values
#   $_[2] Scalar. y-intercept of a line
#   $_[3] Scalar. The mean of the set of y-values in question.
sub explained_var {
    my $slope = shift;
    my $x_vals = shift;
    my $y_int = shift;
    my $y_mean = shift;
    my $ev = 0; #explained variation

    for (my $i = 0; $i < scalar(@$x_vals); $i++) {
        my $y_hat = $slope * $x_vals->[$i] + $y_int; # expected y value
        $ev += (($y_hat - $y_mean) * ($y_hat - $y_mean));
    }

    return $ev;
}

sub find_stats {
    my $list1 = shift;
    my $list2 = shift;

    my %stats = ();

    $stats{X_MEAN}          = &mean         ($list1);
    $stats{X_MIN}           = &min          ($list1);
    $stats{X_MAX}           = &max          ($list1);
    $stats{X_MEDIAN}        = &median       ($list1);
    $stats{X_Q1}            = &q1           ($list1);
    $stats{X_Q3}            = &q3           ($list1);
    $stats{X_IQR}           =               $stats{X_Q3} - $stats{X_Q1};
    $stats{X_UPPER_FENCE}   =               $stats{X_Q3} + (1.5 * $stats{X_IQR});
    $stats{X_LOWER_FENCE}   =               $stats{X_Q1} - (1.5 * $stats{X_IQR});
    $stats{X_STD_DEV_SAM}   = &std_dev_sam  ($list1, $stats{X_MEAN});
    $stats{X_STD_DEV_POP}   = &std_dev_pop  ($list1, $stats{X_MEAN});

    $stats{Y_MEAN}          = &mean         ($list2);
    $stats{Y_MIN}           = &min          ($list2);
    $stats{Y_MAX}           = &max          ($list2);
    $stats{Y_MEDIAN}        = &median       ($list2);
    $stats{Y_Q1}            = &q1           ($list2);
    $stats{Y_Q3}            = &q3           ($list2);
    $stats{Y_IQR}           =               $stats{Y_Q3} - $stats{Y_Q1};
    $stats{Y_UPPER_FENCE}   =               $stats{Y_Q3} + (1.5 * $stats{Y_IQR});
    $stats{Y_LOWER_FENCE}   =               $stats{Y_Q1} - (1.5 * $stats{Y_IQR});
    $stats{Y_STD_DEV_SAM}   = &std_dev_sam  ($list2, $stats{Y_MEAN});
    $stats{Y_STD_DEV_POP}   = &std_dev_pop  ($list2, $stats{Y_MEAN});

    $stats{COR_COEFF}       = &cor_coeff    ($list1, $list2, $stats{X_MEAN}, $stats{Y_MEAN}, $stats{X_STD_DEV_POP}, $stats{Y_STD_DEV_POP});
    $stats{LSQRL_SLOPE}     =               $stats{COR_COEFF} * ($stats{Y_STD_DEV_POP} / $stats{X_STD_DEV_POP});
    $stats{LSQRL_Y_INT}     =               $stats{Y_MEAN} - ($stats{X_MEAN} * $stats{LSQRL_SLOPE});
    $stats{TOTAL_VAR}       = &total_var    ($list2, $stats{Y_MEAN});
    $stats{UNEXPLAINED_VAR} = &unexplained_var($list1, $list2, $stats{LSQRL_SLOPE}, $stats{LSQRL_Y_INT});
    $stats{EXPLAINED_VAR}   = &explained_var($stats{LSQRL_SLOPE}, $list1, $stats{LSQRL_Y_INT}, $stats{Y_MEAN});
    $stats{R2}              =               $stats{EXPLAINED_VAR} / $stats{TOTAL_VAR};

    return \%stats;
}

return 1; # so the use or require suceeds

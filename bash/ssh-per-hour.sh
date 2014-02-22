#!/usr/bin/env sh
#
# Graph out login attempts, by hour.

set -o errexit
set -o nounset
readonly script_name='ssh-per-hour.sh'
readonly usage="usage: ${script_name} <graph.png>

${script_name} searches journalctl for ssh login attempts. The total number of
login attempts occurring each hour of the day is summarized and graphed.

<graph.png>
    The graph to be generated."

# Fetch argument from user.
if [ -z "${1:-}" ]; then
    echo "${usage}"
    exit 1
else
    readonly graphfile="$(readlink -f "${1}")"
fi

# Generate data set.
readonly datafile=$(mktemp)
journalctl \
    --since='2014-01-01' \
    --until='2014-02-01' \
    --no-pager \
    _SYSTEMD_UNIT=sshd.service \
| grep input_userauth_request \
| awk '{print $3}' \
| awk -F : '{print $1}' \
| sort \
| uniq --count \
> "${datafile}"

# Plot data set.
# Use `echo` instead of a heredoc so output redirection can be used.
echo "
    # X AXIS
    # Add 0.5 to xrange so histogram bars do not fall off chart.
    set xrange [-0.5:23.5]
    set xlabel 'Hour'
    set xtics 1

    # Y AXIS
    set ylabel 'Login Attempts'

    # ENTIRE GRAPH
    set title 'SSH Login Attempts by Hour'
    set style data histogram
    set style fill solid
    set boxwidth 0.9
    set font '/usr/share/fonts/TTF/LiberationSans-Regular.ttf'

    # OUTPUTS
    set terminal png size 1024,768
    plot '${datafile}' using 2:1 with boxes title ''
" | gnuplot > "${graphfile}"

# Remove data set.
rm "${datafile}"

#!/usr/bin/env sh
#
# Graph out login attempts, by day

set -o errexit
set -o nounset
readonly script_name='ssh-per-hour.sh'
readonly usage="usage: ${script_name} <graph.png>

${script_name} searches journalctl for ssh login attempts. The total number of
logins attempted on each day is summarized and graphed.

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
    --output=short-iso \
    _SYSTEMD_UNIT=sshd.service \
| grep input_userauth_request \
| awk -F T '{print $1}' \
| sort \
| uniq --count \
> "${datafile}"

# Plot data set.
# Use `echo` instead of a heredoc so output redirection can be used.
echo "
    # X AXIS
    set xlabel 'Date'
    set xdata time
    set timefmt '%Y-%m-%d' # input
    set format x '%Y-%m-%d' # output
    set xtics rotate
    set xtics 86400 # seconds

    # Y AXIS
    set ylabel 'Login Attempts'

    # ENTIRE GRAPH
    set title 'SSH Login Attempts Per Day'
    set style data histogram
    set style fill solid
    set font '/usr/share/fonts/TTF/LiberationSans-Regular.ttf'

    # OUTPUTS
    set terminal png size 1024,768
    plot '${datafile}' using 2:1 with boxes title ''
" | gnuplot > "${graphfile}"

# Remove data set.
rm "${datafile}"

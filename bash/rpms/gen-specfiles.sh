#!/usr/bin/env bash
# coding=utf-8
set -euo pipefail

# Assume this script has been called from the makefile.
source ./common.sh

# See: http://mywiki.wooledge.org/BashFAQ/028
readonly script_name='gen-specfiles.sh'

readonly default_count=5

# Print usage instructions to stdout.
show_help() {
fmt <<EOF
Usage: $script_name [options] <output-dir>

Generate some number of .spec files, and place them into <output-dir>.
<output-dir> need not exist, but all parent directories must exist. The .spec
files are named:

* 100-files-1.spec
* 100-files-2.spec
* 100-files-3.spec

...and so on.

Options:
    --count <integer>
        The number of .spec files to generate. Defaults to ${default_count}.
EOF
}

# Transform $@. $temp is needed. If omitted, non-zero exit codes are ignored.
check_getopt
temp=$(getopt \
    --options '' \
    --longoptions count: \
    --name "$script_name" \
    -- "$@")
eval set -- "$temp"
unset temp

# Read arguments. (getopt inserts -- even when no arguments are passed.)
if [ "${#@}" -eq 1 ]; then
    show_help
    exit 0
fi
while true; do
    case "$1" in
        --count) count="$2"; shift 2;;
        --) shift; break;;
        *) echo "Internal error! Encountered unexpected argument: $1"; exit 1;;
    esac
done
output_dir="$(realpath "$1")"
shift 1
count="${count:-${default_count}}"

# Create a workspace, and schedule it for deletion.
cleanup() { if [ -n "${working_dir:-}" ]; then rm -rf "${working_dir}"; fi }
trap cleanup EXIT  # bash pseudo signal
trap 'cleanup ; trap - SIGINT ; kill -s SIGINT $$' SIGINT
trap 'cleanup ; trap - SIGTERM ; kill -s SIGTERM $$' SIGTERM
working_dir="$(mktemp --directory)"

# Create .spec files.
for ((i=1; i<=count; i++)); do
cat >"${working_dir}/100-files-${i}.spec" <<EOF
Name:      100-files-${i}
Version:   1
Release:   1%{?dist}
Summary:   One hundred files.
License:   Public Domain
URL:       https://github.com/PulpQE/pulp-fixtures
BuildArch: noarch

%description
One hundred files. Useful for basic testing of applications or tools that manage
RPM files, such as Pulp.

%prep

%build
# rpmbuild cd's to the BUILD dir at the beginning of the build and install
# steps.
for i in {1..100}; do
    touch "\${i}"
done

%install
mkdir -p %{buildroot}/opt/%{name}
cp -t %{buildroot}/opt/%{name} *

%files
# Must be absolute paths.
/opt/%{name}
EOF
done

# Create or populate $output_dir.
#
# A $working_dir is used to make fixture generation more atomic. If fixture
# generation fails, this script (or the calling make target) can be run again
# without worrying about cleanup work. $working_dir is copied rather than moved
# to prevent cleanup() from reaping an innocent directory. --no-preserve is used
# because `mktemp -d` creates directories with a mode of 700, and a mode of 755
# (or whatever the umask dictates) is desired.
if [ -d "${output_dir}" ]; then
    cp -r --no-preserve=mode --reflink=auto "${working_dir}"/* "${output_dir}"
else
    cp -r --no-preserve=mode --reflink=auto "${working_dir}" "${output_dir}"
fi

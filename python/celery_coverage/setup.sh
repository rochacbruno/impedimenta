#!/usr/bin/env bash
set -euo pipefail

pyvenv env
set +u
source env/bin/activate
set -u
pip install --upgrade pip
pip install coverage celery
cp coverage_sitecustomize.py env/lib/python3.5/site-packages/sitecustomize.py
cat <<EOF

After ensuring an AMQP broker is running, you may execute the following:

    export COVERAGE_PROCESS_START="$(realpath --canonicalize-existing ./coverage.rc)"
    source env/bin/activate
    celery worker  --app myapp --loglevel info # first terminal
    python -c 'from myapp import add; add.delay(2, 3)'  # second terminal
    coverage combine
    coverage report --show-missing

EOF

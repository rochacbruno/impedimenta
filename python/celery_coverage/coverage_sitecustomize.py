# coding=utf-8
"""Ensure \`Coverage\`_ can measure coverage even when sub-processes are used.

By default, Coverage can only measure coverage for single-processes programs.
This module ensures that multi-process programs may be measured. A
\`\`COVERAGE_PROCESS_START\`\` environment variable must also be set. For
details, see \`Measuring sub-processes\`_.

For details on \`\`sitecustomize.py\`\`, see the standard library documentation
on \`site\`_. Know that when the Python interpreter is started, this module is
imported.

.. _Coverage: https://coverage.readthedocs.io/
.. _Measuring sub-processes:
    https://coverage.readthedocs.io/en/latest/subprocess.html
.. _site: https://docs.python.org/3.5/library/site.html
"""
import coverage

coverage.process_startup()

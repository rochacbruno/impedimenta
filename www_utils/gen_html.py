#!/usr/bin/env python
'''Compile HTML from template, markdown, and config files. Print HTML to stdout.

Usage: ``{} /template/dir /markdown/file /config/file``

Returns 0 upon success. Returns 2 if command has a syntax error. Returns 1 for
any other error.

The config file *must* contain the parameter ``template_path``.
``template_path`` specifies which file inside ``/template/dir`` will be used to
generate HTML. The config file should also contain additional parameters to
populate the template chosen. For example, a config file might be::

    # The template title.html contains two variables: `$content` and `$title`.
    # `$content` will automatically be interpolated, and we need to specify a
    # value for `$title`. The pound sign *must* be the first character in a line
    # for that line to be considered a comment.
    template = title.html
    title = Index

The template files *must* contain the variable ``$content``. Other variables are
optional. Variables may be written as ``$variable`` or ``${variable}``. For
example::

    <html>
        <head>
            <title>$title</title>
        </head>
        <body>$content</body>
    </html>

The ``/markdown/file`` will be compiled to HTML and inserted into the template
at the ``$content`` variable.

'''
import sys, subprocess, string, re
from os import path

USAGE = "Usage: {} /template/dir /markdown/file /config/file".format(__file__)
DEPENDENCIES = ['markdown']

def main():
    # Ensure arguments are valid.
    if(4 != len(sys.argv)):
        print(USAGE)
        return 2
    template_dir = path.abspath(sys.argv[1])
    markdown_file = path.abspath(sys.argv[2])
    config_file = path.abspath(sys.argv[3])

    # Ensure dependencies exist.
    for dependency in DEPENDENCIES:
        if(0 != subprocess.call(
            ['which', dependency],
            stdout = subprocess.DEVNULL,
            stderr = subprocess.DEVNULL,
        )):
            print("Missing dependency: {}".format(dependency))
            return 1

    # Compile markdown to html.
    try:
        # universal_newlines: resultant HTML should contain actual newlines, not
        # the '\n' character
        html = subprocess.check_output(
            ['markdown', markdown_file],
            stderr = subprocess.DEVNULL,
            universal_newlines = True,
        )
    except subprocess.CalledProcessError as err:
        print("Error: {}".format(err))
        return 1

    # Read and parse, and populate config file.
    try:
        with open(config_file, 'r') as handle:
            config = handle.read()
    except IOError as err:
        print("Error: {}".format(err))
        return 1
    opts = parse_cfg(config)
    opts['content'] = html

    # Read template file.
    template_file = template_dir + '/' + opts["template"]
    try:
        with open(template_file, 'r') as handle:
            template = handle.read()
    except IOError as err:
        print("Error: {}".format(err))
        return 1

    # Create html from template + opts
    print(string.Template(template).safe_substitute(opts))
    return 0

def parse_cfg(cfg_file):
    '''Return the options in string cfg_file as a dict.

    Usage::

        >>> config = """ #opt1 = #val1
        ... opt2 = val2
        ... opt_3 = val 3
        ... # valid comment
        ...  # zinvalid = comment"""
        >>> opts = parse_cfg(config)
        >>> ["{}: {}".format(key, opts[key]) for key in sorted(opts.keys())]
        ['#opt1: #val1', 'opt2: val2', 'opt_3: val 3', 'zinvalid: comment']

    '''
    opts = {}
    for line in cfg_file.rsplit('\n'):
        line = re.sub(r'^#.*', '', line) # strip comments...
        line = re.sub(r'^\s+', '', line) # leading whitespace...
        line = re.sub(r'\s+$', '', line) # and trailing whitespace.
        match = re.search(r'(\S+)\s*=\s*(.*)', line)
        try:
            opts[match.group(1)] = match.group(2)
        except (IndexError, AttributeError):
            pass
    return opts

if "__main__" == __name__:
    #import doctest
    #doctest.testmod()
    sys.exit(main())

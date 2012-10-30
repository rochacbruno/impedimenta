#!/usr/bin/env python
'''Compiles a markdown file to HTML and inserts it into a template file.

The template *must* contain the string ``$content`` or ``${content}; this is
where the HTML is inserted into the template. The resultant html file is printed
to stdout.

Returns 2 if a syntax error exists. Returns 1 for any other error. Returns 0
upon success.

'''
import sys, subprocess, string
from os import path

USAGE = "Usage: {} /path/to/template /path/to/markdown".format(__file__)
DEPENDENCIES = ['markdown']

def main():
    # Ensure arguments are valid.
    if(3 != len(sys.argv)):
        print(USAGE)
        return 2
    template_path = path.abspath(sys.argv[1])
    markdown_path = path.abspath(sys.argv[2])

    # Ensure dependencies exist.
    for dependency in DEPENDENCIES:
        if(0 != subprocess.call(['which', dependency])):
            print("Missing dependency: {}".format(dependency))
            return 1

    # Read template and compile markdown to html.
    try:
        with open(template_path, 'r') as handle:
            template = handle.read()
    except IOError as err:
        print("Error: {}".format(err))
        return 1
    try:
        html = subprocess.check_output(
            ['markdown', markdown_path],
            universal_newlines = True
        )
    except subprocess.CalledProcessError as err:
        print("Error: {}".format(err))
        return 1

    # Inject html into template.
    print(string.Template(template).safe_substitute(content=html))
    return 0

if "__main__" == __name__:
    sys.exit(main())

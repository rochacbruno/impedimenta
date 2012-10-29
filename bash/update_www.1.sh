#!/bin/bash
# Copy ichimonji10's www folder to www.1, convert markdown files to HTML, and
# link www to www.1.

cd /media/external1/lighttpd
rsync -r --delete /media/external1/ichimonji10/docs/www/ ./www.1
./convert_markdown.sh ./www.1
ln -snf ./www.1 ./www

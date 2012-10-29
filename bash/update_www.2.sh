#!/bin/bash
# Copy ichimonji10's www folder to www.2, convert markdown files to HTML, and
# link www to www.2.

cd /media/external1/lighttpd
rsync -r --delete /media/external1/ichimonji10/docs/www/ ./www.2
./convert_markdown.sh ./www.2
ln -snf ./www.2 ./www

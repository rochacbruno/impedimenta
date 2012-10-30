#!/bin/bash
# Clean the bzr branch TARGET_DIR and bring it up to date. Recursively search
# TARGET_DIR for paired .markdown and .cfg files, and use GEN_HTML_SCRIPT to
# generate HTML from them. Inform the scipt that templates for generating HTML
# exist at TEMPLATES_DIR. Save the resultant HTML in the same location as the
# .markdown and .cfg files, but with a .html extension.

TARGET_DIR="/path/to/mdown_cfg_http/dir"
TEMPLATES_DIR="/path/to/templates/dir"
GEN_HTML_SCRIPT="/path/to/gen_html.py"

bzr clean-tree --detritus --force --directory "$TARGET_DIR"
bzr update "$TARGET_DIR"
find "$TARGET_DIR" -type f -name \*.markdown | while read mdown_file; do
    cfg_file="${mdown_file%markdown}cfg"
    html_file="${mdown_file%markdown}html"
    "$GEN_HTML_SCRIPT" "$TEMPLATES_DIR" "$mdown_file" "$cfg_file" > "$html_file"
done

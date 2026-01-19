#!/bin/bash
# Remove "What About Dash?" sections from R and ggplot2 markdown files
# These sections are at the end of each file and not relevant to this docs site

set -e

remove_dash_section() {
    local file="$1"
    if grep -q "### What About Dash?" "$file"; then
        # Remove everything from "### What About Dash?" to end of file
        sed -i '' '/^### What About Dash?/,$d' "$file"
        echo "Cleaned: $file"
    fi
}

export -f remove_dash_section

echo "Removing 'What About Dash?' sections..."

# Process R docs
find _posts/r/md -name "*.md" -exec bash -c 'remove_dash_section "$0"' {} \;

# Process ggplot2 docs
find _posts/ggplot2/md -name "*.md" -exec bash -c 'remove_dash_section "$0"' {} \;

echo "Done!"

#!/bin/sh

set -eu

if [ "$#" -ne "1" ]; then
    echo "Usage: ${0} URL"
else
    curl "${1}" | xsltproc --html any-to-ssml.xslt - 2>/dev/null
fi

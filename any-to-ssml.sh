#!/bin/sh

set -eu

if [ "$#" -ne "1" ]; then
    echo "Usage: ${0} URL"
else
    curl "${1}" | \
        xsltproc --html any-to-ssml.xslt - 2>/dev/null | \
        sed -E 's#(\w):in(nen)?(\W)#\1<break strength="x-weak"/>in\2\3#g' | \
        sed -E 's#(\w)\*in(nen)?(\W)#\1<break strength="x-weak"/>in\2\3#g' | \
        sed -E 's#(\w)_in(nen)?(\W)#\1<break strength="x-weak"/>in\2\3#g' | \
        sed -E 's#([a-z])In(nen)?(\W)#\1<break strength="x-weak"/>in\2\3#g'
fi

#!/bin/sh
cd /tmp
wget -r -nd --delete-after -A .html http://incise.org 2>&1 |
    grep ^-- |
    cut -d' ' -f3 |
    grep '^http://incise.org/.*\.html$' |
    sed 's,^http://incise.org/,,' |
    sort -u


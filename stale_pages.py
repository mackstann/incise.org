#!/usr/bin/env python

import os, urllib2

reachable = set(map(urllib2.unquote, os.popen('./reachable-pages.sh').read().strip().split('\n')))
existing = set(os.popen('find pages -name "*.html" | sed "s,^pages/,,"').read().strip().split('\n'))

dead = reachable - existing

if dead:
    print "The following pages should be deleted from the server:"
    print
    print '\n'.join(dead)


#!/usr/bin/env python

import json, urllib2, pprint

url = 'http://github.com/api/v1/json/mackstann'
data = json.read(urllib2.urlopen(url).read())

repositories = sorted([
    r for r in data['user']['repositories']
    if not r['private']
], cmp=lambda a, b: cmp(a['name'].lower(), b['name'].lower()))

# repository attributes:
# ['watchers', 'description', 'url', 'private', 'owner', 'forks', 'homepage', 'name']

for r in repositories:
    print '<a href="%s">%s</a>%s' % (
        r['url'],
        r['name'],
        ' - '+r['description'] if 'description' in r else ''
    )


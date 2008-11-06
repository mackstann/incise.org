#!/usr/bin/env python

import sys, BeautifulSoup

soup = BeautifulSoup.BeautifulSoup(sys.stdin.read())

def nl2p(nodes):
    for node in nodes:
        if isinstance(node, BeautifulSoup.NavigableString):
            try:
                node.replaceWith(node.string.replace('\n\n', '\n<p>\n'))
            except AttributeError:
                pass
        elif node.name != 'pre':
            nl2p(node)

nl2p(soup.findAll('body'))

print soup


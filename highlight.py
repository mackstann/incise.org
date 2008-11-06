#!/usr/bin/env python

import sys
import BeautifulSoup
import pygments, pygments.lexers, pygments.formatters

class CodeHtmlFormatter(pygments.formatters.HtmlFormatter):
    def wrap(self, source, outfile):
        # no div or pre wrapper elements
        return source

soup = BeautifulSoup.BeautifulSoup(sys.stdin.read())

pres = soup.findAll('pre')

def unescape_entities(s):
    return BeautifulSoup.BeautifulStoneSoup(
        s, convertEntities=BeautifulSoup.BeautifulStoneSoup.HTML_ENTITIES
    ).contents[0]

for pre in pres:
    if 'class' not in dict(pre.attrs):
        continue
    code = pre.contents[0]
    code_text = code.contents[0]
    lexer = pygments.lexers.get_lexer_by_name(dict(pre.attrs)['class'])
    formatter = CodeHtmlFormatter(classprefix='pyg-')

    code.replaceWith(
        BeautifulSoup.BeautifulSoup(
            '<pre><code>'+pygments.highlight(
                unescape_entities(unicode(code_text)),
                lexer, formatter
            )+'</code></pre>'
        ).contents[0].contents[0]
    )

print soup


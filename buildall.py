#!/usr/bin/env python

import os, sys, re
import BeautifulSoup
import pygments, pygments.lexers, pygments.formatters

def makepage(content, title, css, ctime, mtime):
    titledate = '' if ctime == "long ago.." else ctime

    return '''
<html>
<head>
<title>incise.org - %(title)s</title>
<link rel="stylesheet" type="text/css" href="/pygments.css" /> 
<style type="text/css">
    body { font-family: sans-serif; max-width: 750px; }
    p { line-height: 1.4em; }
    table, tr { background: #aaa; }
    td, th { background: white; }
    address { font-size: small; }
    .titledate { font-size: small; color: #555; vertical-align: super; }
    pre { background: #ffe; border: 1px solid #666; padding: 5px; }

    .pyg-c, .pyg-cm, .pyg-c1, .pyg-cs, .pyg-ge, .pyg-sd { font-style: normal; }
    .pyg-err { border: none; }

    %(css)s
</style>
</head>
<body>
<h1>
    <a href="/">[incise.org]</a>
    %(title)s
    <span class="titledate">%(titledate)s</span>
</h1>

%(content)s

<hr>
<address>
Nick Welch <a href="mailto:nick@incise.org">&lt;nick@incise.org&gt;</a><br>
this page created %(ctime)s.  last modified %(mtime)s.
</address>
</body>
</html>
''' % locals()

def nl2p(nodes):
    for node in nodes:
        if isinstance(node, BeautifulSoup.NavigableString):
            try:
                node.replaceWith(node.string.replace('\n\n', '\n<p>\n'))
            except AttributeError:
                pass
        elif node.name != 'pre':
            nl2p(node)

def paragraphify(text):
    soup = BeautifulSoup.BeautifulSoup(text)
    nl2p(soup.findAll('body'))
    return str(soup)


class CodeHtmlFormatter(pygments.formatters.HtmlFormatter):
    def wrap(self, source, outfile):
        # no div or pre wrapper elements
        return source

def unescape_entities(s):
    return BeautifulSoup.BeautifulStoneSoup(
        s, convertEntities=BeautifulSoup.BeautifulStoneSoup.HTML_ENTITIES
    )

def highlight(text):

    soup = BeautifulSoup.BeautifulSoup(text)

    pres = soup.findAll('pre')

    for pre in pres:
        cclass = dict(pre.attrs).get('class')
        if cclass is None:
            continue
        code = pre.contents[0]
        code_text = code.contents[0]
        lexer = pygments.lexers.get_lexer_by_name(cclass)
        formatter = CodeHtmlFormatter(classprefix='pyg-')

        code.replaceWith(
            BeautifulSoup.BeautifulSoup(
                ('<pre class="%s"><code>' % cclass)+pygments.highlight(
                    unescape_entities(unicode(code_text)).contents[0],
                    lexer, formatter
                )+'</code></pre>'
            ).contents[0].contents[0]
        )

    return str(soup)

def run():
    os.system("mkdir -p output")
    
    print >>file('output/pygments.css', 'w'), \
        pygments.formatters.HtmlFormatter(classprefix="pyg-").get_style_defs()

    for line in os.popen("find pages -type f -name '*.html'"):
        fn = line.rstrip('\n')

        dates = os.popen("git log --date=short '%s' | grep ^Date: | awk '{print $2}'" % fn).read().split()
        ctime = dates[-1]
        mtime = dates[0]
        if ctime == '2008-06-05': ctime = "long ago.."
        if mtime == '2008-06-05': mtime = "long ago.."

        dir = os.path.dirname(fn)
        base = os.path.splitext(os.path.basename(fn))[0]
        titlefile = "%s/%s.title" % (dir, base)
        cssfile = "%s/%s.css" % (dir, base)

        if os.path.isfile(titlefile):
            title = file(titlefile).read().strip()
        else:
            title = base.replace('-', ' ')

        if os.path.isfile(cssfile):
            css = file(cssfile).read().strip()
        else:
            css = ''

        outdir = re.sub('^pages', 'output', dir)
        outfile = "%s/%s" % (outdir, os.path.basename(fn))
        os.system("mkdir -p '%s'" % outdir)

        content = file(fn).read()
        content = makepage(content, title, css, ctime, mtime)
        content = paragraphify(content)
        content = highlight(content)
        print >>file(outfile, 'w'), content

if __name__ == "__main__":
    run()


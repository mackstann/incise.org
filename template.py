#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import re
import sys


def build_page(template_filename, page_filename):
    title_filename = 'title/' + os.path.basename(page_filename)
    title_content_filename = 'title_content/' + os.path.basename(page_filename)

    template = read(template_filename)
    page = read(page_filename)

    title = read(title_filename).strip()
    title_content = '<br /><p><a href="/">← home</a></p><h1 class="sitetitle">' + title + '</h1>'
    if os.path.exists(title_content_filename):
        title_content = read(title_content_filename)

    result = template
    result = replace_placeholder(result, '__TITLE__', title)
    result = replace_placeholder(result, '__TITLE_CONTENT__', title_content)
    result = replace_placeholder(result, '__CONTENT__', page)

    return result


def read(filename):
    with open(filename) as f:
        return f.read()


def replace_placeholder(body, placeholder, content):
    new_contents = []
    for line in body.splitlines():
        if line.strip() == placeholder:
            parts = list(line.partition(placeholder))
            parts[1] = content
            line = ''.join(parts)
        new_contents.append(line)
    return '\n'.join(new_contents)


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: %s <template file> <page file>" % sys.argv[0])
        raise SystemExit(1)
    template = sys.argv[1]
    page = sys.argv[2]
    print(build_page(template, page))

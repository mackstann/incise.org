#!/usr/bin/env python

import os
import re
import sys


def build_page(template_filename, page_filename):
    title_filename = 'title/' + os.path.basename(page_filename)
    title_content_filename = 'title_content/' + os.path.basename(page_filename)

    template = read(template_filename)
    page = read(page_filename)

    title = read(title_filename).strip()
    title_content = '<a href="/">incise.org</a>: ' + title
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


#def replace_section(body, placeholder, content):
#    in_section = False
#    contents = []
#    for line in body.splitlines():
#        line = line.strip()
#        if line == 'BEGIN ' + section_name:
#            if in_section:
#                raise RuntimeError("Duplicate opening of section %s in %s",
#                    section_name, filename)
#            in_section = True
#        elif line == 'END ' + section_name:
#            if not in_section:
#                raise RuntimeError("Duplicate closing of section %s in %s",
#                    section_name, filename)
#            in_section = False
#        elif in_section:
#            if contents[-1] is not None:
#                contents.append(None)
#        else:
#            contents.append(line)
#    idx = contents.index(None)
#    contents[idx] = content
#    return '\n'.join(contents)


def replace_placeholder(body, placeholder, content):
    new_contents = []
    for line in body.splitlines():
        if line.strip() == placeholder:
            parts = list(line.partition(placeholder))
            parts[1] = content
            line = ''.join(parts)
        new_contents.append(line)
    return '\n'.join(new_contents)


#def extract_section(body, section_name):
#    in_section = False
#    contents = []
#    for line in body.splitlines():
#        line = line.strip()
#        if line == 'BEGIN ' + section_name:
#            if in_section:
#                raise RuntimeError("Duplicate opening of section %s in %s",
#                    section_name, filename)
#            in_section = True
#        elif line == 'END ' + section_name:
#            if not in_section:
#                raise RuntimeError("Duplicate closing of section %s in %s",
#                    section_name, filename)
#            in_section = False
#        elif in_section:
#            contents.append(line)
#    return '\n'.join(contents)


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: %s <template file> <page file>" % sys.argv[0])
        raise SystemExit(1)
    template = sys.argv[1]
    page = sys.argv[2]
    print(build_page(template, page))

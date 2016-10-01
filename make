#!/usr/bin/python3

import yaml
import subprocess
from jinja2 import Environment, FileSystemLoader


def main():
    with open('cv.yml', 'r') as f:
        data = yaml.load(f)

    env = Environment()
    env.loader = FileSystemLoader('assets')
    tmpl = env.get_template('template.html')
    html = tmpl.render(**data)

    fname = 'out/cv.html'
    pdfname = 'out/cv.pdf'
    with open(fname, 'w') as f:
        f.write(html)

    subprocess.call([
        'wkhtmltopdf',
        '-q',       # quiet
        '-T', '0',  # top margin
        '-L', '0',  # left margin
        '-R', '0',  # right margin
        '--zoom', '0.8',
        fname,
        pdfname
    ])

    return pdfname


if __name__ == '__main__':
    pdfname = main()
    print(pdfname)
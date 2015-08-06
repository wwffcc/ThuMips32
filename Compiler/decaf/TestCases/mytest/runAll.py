#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import subprocess
import sys
import re

filter = re.compile(
    '^(SPIM Version|Copyright|All Rights|.*copyright|Loaded:).*\n', re.M)


def read_txt_file(filename):
    with open(filename, 'r') as f:
        txt = f.read().strip()
    # Python should be able to do it automatically, but just in case...
    txt = txt.replace('\r', '')
    # Remove version/copyright info of SPIM
    txt = filter.sub('', txt)
    return txt


def get_spim():
    '''Return (dir, exe)'''
    if os.name == 'nt':  # Windows
        spim = 'spim.exe'
    # Mac OS (FIXME: NOT TESTED! PLEASE MAKE CHANGES TO THIS SCRIPT IF
    # NECESSARY)
    elif sys.platform == 'darwin':
        spim = './spim.mac'
    elif sys.platform.startswith('linux'):  # Linux (x86/amd64)
        spim = './spim.linux'
    else:
        print("What the hell OS are you using?!!")
        sys.exit(1)
    return os.path.join('..', '..', 'tools', 'spim'), spim

if __name__ == '__main__':
    decaf_jar = os.path.join('..', '..', 'result', 'decaf.jar')
    names = sys.argv[1:]
    if not names:
        names = sorted(os.listdir('.'))
    for name in names:
        bname, ext = os.path.splitext(name)
        if ext != '.decaf':
            continue

        cmd = ['java', '-jar', decaf_jar, '-l', '2', name]

        code = subprocess.call(cmd,
                               stdout=open(
                                   os.path.join('output', bname + '.tac'), 'w'),
                               stderr=subprocess.STDOUT)

        # Run the test case, redirecting stdout/stderr to output/bname.dout
        cmd = ['java', '-jar', decaf_jar, '-l', '3', name]
        code = subprocess.call(cmd,
                               stdout=open(
                                   os.path.join('output', bname + '.dout'), 'w'),
                               stderr=subprocess.STDOUT)

        cmd = ['java', '-jar', decaf_jar, '-l', '4', name]
        code = subprocess.call(cmd,
                               stdout=open(
                                   os.path.join('output', bname + '.s'), 'w'),
                               stderr=subprocess.STDOUT)

        if name == 'blackjack.decaf':
            continue

        fw = open(os.path.join('output', bname + '.result'), 'w')
        if code == 0:  # Run SPIM
            spim_dir, spim_exe = get_spim()
            # On Windows, argv[0] is relative to original dir;
            # On Unix, argv[0] is relative to cwd (spim_dir). So we use
            # absolute path here.
            spim_exe = os.path.abspath(os.path.join(spim_dir, spim_exe))
            asm_abspath = os.path.abspath(os.path.join('output', bname + '.s'))
            subprocess.call(
                [spim_exe, asm_abspath],
                cwd=spim_dir,
                stdout=fw,
                stderr=subprocess.STDOUT)
        fw.close()

#!/usr/bin/env python

import sys

flag = False

link_prefix = 'git://github.com'

allLines = sys.stdin.readlines()
for curLine in allLines:
    if curLine.find('repo-list-name')>= 0:
        flag = True
    if flag:
        pos = curLine.find('href="')
        if pos >= 0:
            pos += len('href="')
            last = curLine['"']
            end = last.find('"')
            link = last[:end]

        # name to path
        name = link[link.rfind('/')+1:]
        prefix = name.find('platform_')
        if prefix >=0:
            name = name[len('platform_'):]  # ignore platform_
        path = name.replace('_','/')

        link = link_prefix + link
        # print 'curl',link,'>',name
        # https://github.com/android/platform_external_qemu.git
        print 'git clone',link + '.git',path # 输出git clone命令
        flag = False

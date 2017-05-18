#!/bin/bash

sudo mount /dev/$1 $2 -o uid=1000,gid=1000,iocharset=utf8

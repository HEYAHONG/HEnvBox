#!/bin/bash

#启用软链接创建
sed -i "s/#MSYS=winsymlinks:nativestrict/MSYS=winsymlinks:nativestrict/g"  /clang32.ini  /clang64.ini  /clangarm64.ini  /mingw32.ini  /mingw64.ini  /msys2.ini  /ucrt64.ini  2> /dev/null

#!/bin/bash

#测试程序(通过which测试)，参数1为程序名
function EnvCheckTestProgram
{
        [  -n "$1"  ] ||
        {
                return 255;
        };
        ToolPath=`which $1 2> /dev/null`;
        [ -e "$ToolPath" ] ||
        {
                 return 255;
        };
        return 0;
}





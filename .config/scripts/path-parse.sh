#!/bin/bash
windows_home=${WINDOWS_HOME:-novardefined}

cat | sed -e "s|^ |$windows_home|" -e "s|^~/|$HOME/|"

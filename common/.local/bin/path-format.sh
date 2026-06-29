#!/usr/bin/env bash
windows_home=${WINDOWS_HOME:-novardefined}

cat | sed -e "s|^$HOME|~|" -e "s|^$windows_home| |";

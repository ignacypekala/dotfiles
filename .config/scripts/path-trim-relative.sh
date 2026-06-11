#!/bin/bash
# Trim a path from standard input to a size equal to p% * terminal width
#
# Usage
# path-trim-relative.sh [p%] [minimum width]

columns=$(tput cols)
columns=$(( $columns * p / 100 ))
path-trim.sh $columns

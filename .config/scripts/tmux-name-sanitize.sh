#!/usr/bin/env bash
# Colons and periods are not allowed in tmux session names. Replace characters
# ":" and "." with their hex values prefixed by %.
name=${1//:/%3A}
echo ${name//./%2E}

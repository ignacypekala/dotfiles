#!/usr/bin/env bash
name=${1//%3A/:}
echo ${name//%2E/.}

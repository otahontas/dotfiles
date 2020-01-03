#!/bin/sh
# Passes row given as 2nd argument from password given as 1st argument to
# stdout
password=$1
linenum=$2
pass $password | sed "${linenum}q;d"

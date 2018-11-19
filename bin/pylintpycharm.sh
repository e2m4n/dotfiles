#!/bin/bash
#pylint $1 | sort -t ":" -k 2,2n
/home/aaron/git/pylint-pycharm/build/scripts-2.7/pylint-pycharm $1 $2 $3 $4 $5 | sort -t ":" -k 2,2n

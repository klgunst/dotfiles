#!/usr/bin/env python2
from subprocess import check_output

def get_ugentpass():
        return check_output("pass PhD/UGent", shell=True).split("\n")[0]

def get_hotmailpass():
        return check_output("pass BigGuys/Microsoft | grep App-password | sed 's/App-password=//'", shell=True).strip("\n")

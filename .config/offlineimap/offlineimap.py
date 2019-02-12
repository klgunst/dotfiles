#!/usr/bin/env python2
from subprocess import check_output

def get_ugentpass():
        return check_output("pass Work/UGent", shell=True).strip("\n")

def get_hotmailpass():
        return check_output("pass BigGuys/Windows | grep App-password | sed 's/App-password=//'", shell=True).strip("\n")

def get_caltechpass():
        return check_output("pass Work/Caltech/access | head -n1", shell=True).strip("\n")

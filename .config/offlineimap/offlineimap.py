#!/usr/bin/env python2
from subprocess import check_output

def get_ugentpass():
        return check_output("pass Work/UGent", shell=True).strip("\n")

def get_hotmailpass():
        return check_output("pass Email/hotmail | grep App-password | sed 's/App-password=//'", shell=True).strip("\n")

#!/usr/bin/env python2
from subprocess import check_output

def get_ugentpass():
        return check_output("gpg2 -dq ~/.config/offlineimap/ugent.gpg", shell=True).strip("\n")

def get_hotmailpass():
        return check_output("gpg2 -dq ~/.config/offlineimap/hotmail.gpg", shell=True).strip("\n")

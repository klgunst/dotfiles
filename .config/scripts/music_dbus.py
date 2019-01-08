#!/usr/bin/env python3

from pydbus import SessionBus
from gi.repository import GLib

print("bla")
bus = SessionBus()
# first in this list is the default
busnames = ["org.mpris.MediaPlayer2.Goodvibes", "org.mpris.MediaPlayer2.spotify"]
bus_obj=[None, None]

def multiplaying():
    flag = False
    for el in bus_obj:
        newflag = el is not None and el.PlaybackStatus == 'Playing'
        if newflag and flag:
            return True
        else:
            flag = True
    return False

def playing_obj():
    for el in bus_obj:
        if el is not None and el.PlaybackStatus == 'Playing':
            return el
    return None

def bus_print(data):
    # Radio 1 spamt irrelevante info in xesam:title
    # KEXP geeft zelfs nooit song titel?
    blacklist = ['Radio 1', 'Altijd Benieuwd', 'Radio 1 - Altijd Benieuwd']

    if multiplaying():
        print("Cacophony")
    else:
        try:
            print((data['xesam:artist'])[0], '-', data['xesam:title'])
        except KeyError:
            try:
                if data['xesam:title'] not in blacklist:
                    print(data['xesam:title'] )
            except KeyError:
                print("Missing info")

def bus_add(idx, name):
    bus_obj[idx] = bus.get(busnames[idx], "/org/mpris/MediaPlayer2")
    bus_obj[idx].onPropertiesChanged=lambda InterfaceName,data,c:bus_print(data['Metadata'])

def bus_remove(idx):
    bus_obj[idx] = None

def player_commands(command):
    assert not multiplaying()

    obj = playing_obj() if playing_obj() is not None else bus_obj[0]

    commands = {
            'Play': obj.Play,
            'Pause': obj.Pause,
            'PlayPause': obj.PlayPause,
            'Next': obj.Next,
            'Previous': obj.Previous,
            }
    try :
        commands[command]()
    except KeyError:
        raise ValueError('Invalid input')


if __name__ == '__main__':
    import sys
    assert len(sys.argv) == 2

    # Finding bus for spotify and 
    try:
        for idx,name in enumerate(busnames):
            bus_add(idx, name)
    except:
        pass

    if sys.argv[1] == 'watch':
        bus.watch_name(busnames[0], name_appeared=lambda name:bus_add(0, name), 
                name_vanished=lambda:bus_remove(0))
        bus.watch_name(busnames[1], name_appeared=lambda name:bus_add(1, name), 
                name_vanished=lambda:bus_remove(1))
        GLib.MainLoop().run()
    if sys.argv[1] == 'info'
        print("bla")

    elif multiplaying(): 
        # if cacophony pause irrelevant from command
        bus_obj[0].Pause()
        bus_obj[1].Pause()
    else:
        player_commands(sys.argv[1])

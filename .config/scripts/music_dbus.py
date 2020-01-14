import sys
from pydbus import SessionBus
from gi.repository import GLib

bus = SessionBus()
# first in this list is the default
# Make class from this together with its idx?
busnames = ["org.mpris.MediaPlayer2.Goodvibes", "org.mpris.MediaPlayer2.spotify"]
bus_obj=[None, None]

def multiplaying():
    flag = False
    for el in bus_obj:
        newflag = (el is not None) and el.PlaybackStatus == 'Playing'
        if newflag and flag:
            return True
        elif newflag:
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
    blacklist = ['Radio 1', 'Altijd Benieuwd', 'Radio 1 - Altijd Benieuwd', 'Studio Brussel']

    try:
        metadata = data['Metadata']
    except KeyError:
        print("Missing metadata")
        sys.stdout.flush()
        return

    if multiplaying():
        print("Cacophony")
    else:
        try:
            print((metadata['xesam:artist'])[0], '-', metadata['xesam:title'])
        except KeyError:
            try:
                if metadata['xesam:title'] not in blacklist:
                    try:
                        print(metadata['goodvibes:station'], '-', end=' ')
                    except KeyError:
                        pass

                    print(metadata['xesam:title'] )
            except KeyError:
                print("Missing info")
    sys.stdout.flush()

def bus_add(idx, name):
    bus_obj[idx] = bus.get(busnames[idx], "/org/mpris/MediaPlayer2")
    bus_obj[idx].onPropertiesChanged=lambda InterfaceName,data,c:bus_print(data)

def bus_remove(idx):
    bus_obj[idx] = None

def player_commands(arglist):
    assert not multiplaying()

    if len(arglist) != 2:
        obj = playing_obj() if playing_obj() is not None else bus_obj[0]
        idx = bus_obj.index(obj)
    else:
        idx = int(arglist[1])
        obj = bus_obj[idx]

    if obj is None:
        obj = start_player(idx)

    commands = {
            'Play': obj.Play,
            'Pause': obj.Pause,
            'PlayPause': obj.PlayPause,
            'Next': obj.Next,
            'Previous': obj.Previous,
            }

    try :
        commands[arglist[0]]()
    except KeyError:
        raise ValueError('Invalid input')

def start_player(idx):
    from subprocess import call, Popen
    if idx == 0:
        call(["goodvibes", "-b", "--without-ui", "Radio 1"])
    elif idx == 1:
        Popen(["spotify"])

if __name__ == '__main__':
    # Finding bus for spotify and goodvibes
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
    elif sys.argv[1] == 'info':
        for el in bus_obj:
            if (el is not None) and el.PlaybackStatus == 'Playing':
                data = {'Metadata': el.Metadata}
                bus_print(data)
    elif sys.argv[1] == 'isplaying':
        if not multiplaying():
            objpl = playing_obj()
            if objpl is not None:
                print(bus_obj.index(playing_obj()))
    elif multiplaying(): 
        # if cacophony pause irrelevant from command
        bus_obj[0].Pause()
        bus_obj[1].Pause()
    else:
        player_commands(sys.argv[1:])

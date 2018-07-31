#!/usr/bin/env python

import dbus
session_bus = dbus.SessionBus()

spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.spotify","/org/mpris/MediaPlayer2")
spotify_properties = dbus.Interface(spotify_bus,"org.freedesktop.DBus.Properties")
metadata = spotify_properties.Get("org.mpris.MediaPlayer2.Player", "Metadata")

# To just print the title and artist
print metadata.get('xesam:title').encode('utf-8') + " - " + next(iter(metadata.get('xesam:artist'))).encode('utf-8')

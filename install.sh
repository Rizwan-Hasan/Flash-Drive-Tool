#!/bin/sh
#
#    Copyright 2007-2009 Canonical Ltd.
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License as
#  published by the Free Software Foundation; either version 2 of the
#  License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software Foundation,
#  Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA

LIBFILES="main.py raw_write.py raw_format.py mountutils.py window.ui"
# DATAFILES="flash-drive-tool.glade flash-drive-tool.ui"


if [ "$1" = "uninstall" ]; then
    rm -rf /usr/lib/flash-drive-tool
    rm -rf /usr/share/flash-drive-tool
    rm -r /usr/share/applications/flash-drive-tool.desktop
    rm -r /usr/share/applications/flash-drive-tool-kde.desktop
    rm -r /usr/share/applications/flash-drive-format-tool.desktop
    rm -r /usr/share/applications/flash-drive-format-tool-kde.desktop
    rm -f /usr/bin/flash-drive-tool
    rm -rf /usr/share/kde4/apps/solid/actions/flash-drive-format-tool.desktop
else
    cp share/applications/flash-drive-tool.desktop /usr/share/applications/
    cp share/applications/flash-drive-format-tool.desktop /usr/share/applications/
    cp share/applications/flash-drive-tool-kde.desktop /usr/share/applications/
    cp share/applications/flash-drive-format-tool-kde.desktop /usr/share/applications/
    cp share/kde4/flash-drive-format-tool_action.desktop /usr/share/kde4/apps/solid/actions
    cp flash-drive-tool /usr/bin/
    mkdir -p /usr/lib/flash-drive-tool
    mkdir -p /usr/share/flash-drive-tool

    for item in $LIBFILES; do
        cp lib/$item /usr/lib/flash-drive-tool/
    done

    for item in $DATAFILES; do
        cp share/flash-drive-tool/$item /usr/share/flash-drive-tool/
    done
fi

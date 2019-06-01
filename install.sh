#!/bin/sh


LIBFILES="main.py raw_write.py raw_format.py mountutils.py window.ui"

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
fi

#!/usr/bin/env bash

startProgram() {
    sleep $1
    $2 &
}

sh ./mountDrives.sh

startProgram 3 "discord"
startProgram 4 "obsidian"
startProgram 3 "lutris"
startProgram 3 "steam"
startProgram 3 "pulsemeeter"
startProgram 3 "/usr/bin/emacs --daemon"
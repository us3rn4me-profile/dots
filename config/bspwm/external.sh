#!/usr/bin/env bash
# Input data
wid=$1
class=$2
instance=$3
consequences=$4
window_role=$(xprop -id "$wid" WM_WINDOW_ROLE | awk '{print $3}')
 case "$window_role" in
        "GtkFileChooserDialog")
        echo "state=floating border=off center=true"
        ;;
    esac

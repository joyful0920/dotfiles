#!/bin/bash
# macOS desktop notification hook for Claude Code (Notification / Stop events).
# Reads the hook JSON from stdin and shows a notification via osascript.
# Absolute paths are required: hooks run in a non-login shell.
#
# First-time setup: run `osascript -e 'display notification "test"'` once and
# grant notification permission to Script Editor in System Settings.

input=$(cat)

message=$(printf '%s' "$input" | /usr/bin/jq -r '.message // empty' 2>/dev/null)
event=$(printf '%s' "$input" | /usr/bin/jq -r '.hook_event_name // empty' 2>/dev/null)
cwd=$(printf '%s' "$input" | /usr/bin/jq -r '.cwd // empty' 2>/dev/null)

if [ -z "$message" ]; then
    case "$event" in
        Stop) message="Task finished" ;;
        *) message="Waiting for your input" ;;
    esac
fi

title="Claude Code"
if [ -n "$cwd" ]; then
    title="Claude Code · $(basename "$cwd")"
fi

# Strip double quotes to keep the AppleScript string safe
message=${message//\"/}
title=${title//\"/}

/usr/bin/osascript -e "display notification \"${message}\" with title \"${title}\" sound name \"Glass\""

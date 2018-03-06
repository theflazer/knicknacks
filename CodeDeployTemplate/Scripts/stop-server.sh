#!/bin/bash
re="\[.{2,}\]"
OUTPUT="$(pm2 prettylist)"
echo $OUTPUT
if [[ $OUTPUT =~ $re ]]; then
  echo "Stopping Server"
else
  echo "No server to stop"
fi

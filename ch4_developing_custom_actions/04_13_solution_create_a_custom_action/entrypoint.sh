#!/bin/bash
set -e

echo "👤 Actor       : $GITHUB_ACTOR"
echo "🆔 Commit SHA  : $GITHUB_SHA"
echo "▶️ Event type  : $GITHUB_EVENT_NAME"
echo -n "🔎 Visibility  : "

VISIBILITY=$(jq -r '.repository.visibility' "$GITHUB_EVENT_PATH")

if [[ "$VISIBILITY" == "private" ]]; then
   echo "🔒 This is a PRIVATE repository."
else
  echo "🌍 This is a PUBLIC repository."
fi
#!/bin/bash

# There are certainly better ways to do all of this but I like the transparency in the logs.

# Global default steps setting
DEFAULT_STEP_COUNT="50"
DEF_STEPS=""
if [ "${DEFAULT_STEP_COUNT}" != "50" ] ; then
  echo "Changing default step count to $DEFAULT_STEP_COUNT"
  DEF_STEPS="--default-steps $DEFAULT_STEP_COUNT"
else
  echo "Default steps remaining set to 50"
fi

# Image queuing
QUEUEING=""
if [ "${QUEUEING_ALLOWED}" = "YES" ] ; then
  echo "Image queueing ENABLED"
  QUEUING="--allow-queue"
else
  echo "Image queueing DISABLED"
fi

# NSFW image detection and spoiler tagging
NSFW_SPOILER=""
if [ "${NSFW_SPOILER_ENABLE}" = "YES" ] ; then
  echo "NSFW spoiler tagging ENABLED"
  NSFW_SPOILER="--nsfw-auto-spoiler"
else
  echo "NSFW spolier tagging DISABLED"
fi

# Displays your tokens in the log file if you are troubleshooting issues
PRINT_TOKENS=""
if [ "${PRINT_TOKENS_ENABLE}" = "YES" ] ; then
  echo "Debug display of bot and guild tokens ENABLED."
  echo "bot token - $BOT_TOKEN"
  echo "guild - $GUILD"
else
  echo "Debug display of bot and guild tokens DISABLED."
fi

echo "entrypoint.sh: Launching..."
cd /app/yasd-discord-bot-docker
python3.10 bot.py $BOT_TOKEN -g $GUILD $DEF_STEPS $QUEUEING $NSFW_SPOILER
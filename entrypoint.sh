#!/bin/bash

RUN_ARGS=""
#Queue allow checking
if [ "${RUN_MODE}" = "ALLOW-QUEUE" ] ; then
  echo "Image queueing allowed"
  RUN_ARGS="--allow-queue"
else
  echo "Running without image queues"
fi

PRINT_TOKENS=""
#Displays your tokens in the log file if you are troubleshooting issues
if [ "${PRINT_TOKENS_ENABLE}" = "YES" ] ; then
  echo "bot token - $BOT_TOKEN"
  echo "guild - $GUILD"
else
  echo "Debug display of bot and guild tokens disabled."
fi

NSFW_SPOILER=""
if [ "${NSFW_SPOILER_ENABLE}" = "YES" ] ; then
  echo "NSFW spoiler tagging enabled"
  NSFW_SPOILER="--nsfw-auto-spoiler"
else
  echo "NSFW spolier tagging disabled"
fi
 
if [[ -z $RUN_ARGS ]]; then
    launch_message="entrypoint.sh: Launching..."
else
    launch_message="entrypoint.sh: Launching with arguments ${RUN_ARGS} ${NSFW_SPOILER}"
fi

echo $launch_message
cd /app/yasd-discord-bot-docker
python3.10 bot.py $BOT_TOKEN -g $GUILD $RUN_ARGS $NSFW_SPOILER
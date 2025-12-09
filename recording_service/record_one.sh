#!/bin/bash

DEVICE_ID=$1
M3U8_URL=$2
OUTPUT_DIR="/workspace/recording_service/output"
OUTPUT_FILE="$OUTPUT_DIR/${DEVICE_ID}.mp4"

mkdir -p "$OUTPUT_DIR"

while true; do
  echo "[$(date)] 开始录制 $DEVICE_ID"
  ffmpeg -i "$M3U8_URL" -c copy -t 300 -f mp4 -y "$OUTPUT_FILE" >/dev/null 2>&1
  echo "[$(date)] $DEVICE_ID 录制完成（5分钟），重新开始..."
  sleep 1
done
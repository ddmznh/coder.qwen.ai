#!/bin/bash

cd /workspace/recording_service

while IFS= read -r line; do
  # 跳过空行
  if [ -z "$line" ]; then
    continue
  fi
  
  DEVICE_ID=$(echo "$line" | awk '{print $1}')
  M3U8_URL=$(echo "$line" | cut -d' ' -f2-)
  
  # 后台启动每路录制（可加日志重定向）
  nohup ./record_one.sh "$DEVICE_ID" "$M3U8_URL" > "/workspace/recording_service/logs/${DEVICE_ID}.log" 2>&1 &
  echo "启动录制: $DEVICE_ID"
done < devices.txt

echo "✅ 所有录制任务已启动"
#!/bin/bash

echo "停止所有录制任务..."

# 查找并终止所有 record_one.sh 进程
pids=$(ps aux | grep "record_one.sh" | grep -v grep | awk '{print $2}')
if [ -n "$pids" ]; then
    kill $pids
    echo "已终止录制进程: $pids"
else
    echo "没有找到正在运行的录制进程"
fi

echo "✅ 所有录制任务已停止"
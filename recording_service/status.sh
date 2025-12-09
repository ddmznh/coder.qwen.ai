#!/bin/bash

echo "录制服务状态检查:"
echo "=================="

# 检查录制进程数量
recording_processes=$(ps aux | grep "record_one.sh" | grep -v grep | wc -l)
echo "正在运行的录制进程数: $recording_processes"

# 列出正在运行的录制任务
echo ""
echo "详细进程信息:"
ps aux | grep "record_one.sh" | grep -v grep

# 检查输出目录中的文件
echo ""
echo "输出目录中的文件:"
ls -la /workspace/recording_service/output/

# 检查日志目录中的日志文件
echo ""
echo "日志文件信息:"
ls -la /workspace/recording_service/logs/
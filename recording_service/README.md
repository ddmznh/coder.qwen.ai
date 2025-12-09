# 轻量级 FFmpeg 批量录制服务

这是一个基于 Linux + systemd 或 Docker 的轻量级 FFmpeg 批量录制服务，每路流独立进程，互不影响，且只录 5 分钟自动覆盖。

## 🛠️ 设计特点

- 每一路设备（deviceCode）对应一个独立的录制脚本
- 每个脚本只做一件事：无限循环录制 5 分钟，输出固定文件名
- 使用 `ffmpeg -c copy -t 300`，CPU 占用极低（纯流复制，无转码）
- 支持 systemd 或 supervisor 管理所有录制任务，支持自动重启、日志查看

## 📁 目录结构

```
/recordings/
├── devices.txt                 # 所有要录制的设备列表
├── start_all.sh                # 启动所有录制任务
├── stop_all.sh                 # 停止所有录制任务
├── status.sh                   # 查看录制服务状态
├── record_one.sh               # 单路录制模板
├── recording-manager.service   # systemd 服务配置文件
├── docker-compose.yml          # Docker Compose 配置文件
├── README.md                   # 说明文档
└── output/                     # 输出 MP4 文件目录
    ├── 51090316021322000026.mp4
    ├── 51090316021322000027.mp4
    └── ...
```

## 🔧 使用说明

### 1. 配置设备列表

编辑 `devices.txt` 文件，每行包含设备ID和对应的M3U8 URL：

```
51090316021322000026 http://liveplay.example.com/stream/51090316021322000026.m3u8?auth_key=xxx
51090316021322000027 http://liveplay.example.com/stream/51090316021322000027.m3u8?auth_key=yyy
```

### 2. 启动录制服务

```bash
# 直接运行脚本方式
./start_all.sh

# 或使用 systemd 服务（推荐）
sudo cp recording-manager.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable recording-manager
sudo systemctl start recording-manager
```

### 3. 管理录制服务

```bash
# 查看服务状态
./status.sh

# 停止所有录制
./stop_all.sh
```

### 4. Docker 方式运行

```bash
# 安装 docker-compose
sudo apt install docker-compose

# 启动服务
docker-compose up -d

# 查看日志
docker-compose logs -f

# 停止服务
docker-compose down
```

## 📈 资源与性能说明

| 指标 | 说明 |
|------|------|
| CPU | 每路仅 1%~3%（纯 copy，无编码） |
| 内存 | 每路 ~50MB RAM |
| 磁盘 | 每路 5 分钟 ≈ 100~300MB（取决于码率） |
| 并发能力 | 普通服务器轻松支持 50~100 路 |

## 📌 注意事项

- 确保磁盘空间充足（可加定时清理脚本）；
- 不要用 `-re` 参数（FFmpeg 默认实时拉流，无需模拟实时）；
- MP4 文件正在写入时，部分播放器可能无法播放；
- 建议定期检查日志文件以监控录制状态；

## ✅ 总结

- 工具：直接用 FFmpeg（最成熟、高效、免费）；
- 架构：每路独立脚本 + 后台运行；
- 输出：固定 MP4 文件名，TV 端直接播放；
- 扩展：支持 10~100+ 路，资源占用低。
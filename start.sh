#!/bin/bash
set -e  # 遇到错误立即停止脚本

# 读取环境变量
if [ -f "/app/config.sh" ]; then
    source /app/config.sh
else
    echo "Warning: /app/config.sh not found!"
fi

# 启动 SSH 和 Nginx
echo "Starting SSH and Nginx services..."
service ssh start
service nginx start

# 设置 ngrok 令牌
if [ -n "$NGROK_TOKEN" ]; then
    echo "Setting ngrok token..."
    ngrok authtoken $NGROK_TOKEN
else
    echo "Error: NGROK_TOKEN is not set!"
    exit 1
fi

# 启动 ngrok 并在后台运行
echo "Starting ngrok..."
nohup ngrok tcp 22 --log=stdout > /app/ngrok.log 2>&1 &

echo "All services started successfully!"

#!/bin/bash
set -e  # 遇到错误立即停止

# 确保 /app 目录存在
mkdir -p /app

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
nohup ngrok tcp 22 > /app/ngrok.log 2>&1 &

echo "All services started successfully!"

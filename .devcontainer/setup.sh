#!/bin/bash
echo "Installing project dependencies..."

# 安装 Python 依赖
pip install --upgrade pip
pip install -r requirements.txt

# 安装 C++ 相关工具（如果 MetaVPS 需要）
sudo apt-get install -y build-essential cmake

echo "Setup completed!"

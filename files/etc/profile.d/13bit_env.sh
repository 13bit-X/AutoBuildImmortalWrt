#!/bin/sh
# 13bit-X 专属环境配置

# 一键更新固件命令
update-fw() {
    echo "正在检查 13bit-X/AutoBuildImmortalWrt 仓库的最新固件..."
    
    # 获取下载直链 (针对 x86-64 squashfs-combined-efi.img.gz)
    local API_URL="https://api.github.com/repos/13bit-X/AutoBuildImmortalWrt/releases/latest"
    local DOWNLOAD_URL=$(curl -s $API_URL | grep "browser_download_url" | grep "combined-efi.img.gz" | head -n 1 | cut -d '"' -f 4)
    
    if [ -z "$DOWNLOAD_URL" ]; then
        echo "❌ 错误：未能获取到固件下载链接，请检查仓库 Release 页面。"
        return 1
    fi
    
    echo "✅ 找到最新固件：$(basename $DOWNLOAD_URL)"
    echo "🚀 开始下载并无损升级..."
    
    wget -O /tmp/update_fw.img.gz "$DOWNLOAD_URL"
    
    if [ $? -eq 0 ]; then
        echo "📦 下载完成，准备执行 sysupgrade..."
        # 默认执行无损升级 (保留配置)
        sysupgrade /tmp/update_fw.img.gz
    else
        echo "❌ 下载失败，请检查网络连接。"
        return 1
    fi
}

# 设置别名
alias update-os='update-fw'

echo "✨ 13bit-X 环境已加载。输入 'update-fw' 可一键更新固件。"

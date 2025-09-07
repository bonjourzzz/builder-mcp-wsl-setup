#!/bin/bash
# AWS凭证自动获取脚本

# 自动配置Builder-MCP认证
setup_builder_mcp() {
    # 智能用户检测逻辑
    local wsl_user=$(whoami)
    local windows_user=""
    
    if [[ -d "/mnt/c/Users/$wsl_user" ]]; then
        windows_user="$wsl_user"
    else
        windows_user=$(ls /mnt/c/Users/ | grep -v "^Public$\|^Default\|^All Users$\|^Administrator$\|^Guest$" | head -1)
    fi
    
    mkdir -p ~/.midway
    
    # 复制Windows cookie到WSL，而不是符号链接
    local windows_cookie="/mnt/c/Users/$windows_user/.midway/cookie"
    if [[ -f "$windows_cookie" ]]; then
        cp "$windows_cookie" ~/.midway/cookie
    fi
}

get_aws_credentials() {
    setup_builder_mcp
    
    # 获取凭证并检查是否成功
    response=$(curl -s -k -L -c ~/.midway/cookie -b ~/.midway/cookie -H "Accept: application/json" \
    https://iibs-midway.corp.amazon.com/GetAssumeRoleCredentials \
    --data-urlencode "duration=1000" -G \
    --data-urlencode "roleARN=arn:aws:iam::285552316960:role/BedrockAccess" 2>/dev/null)
    
    # 检查响应是否包含accessKeyId
    if echo "$response" | grep -q "accessKeyId"; then
        echo "✓ AWS验证成功"
        # 可选：将凭证保存到文件
        echo "$response" > ~/.aws_creds.json
    else
        echo "✗ AWS验证失败"
    fi
}

if [[ $- == *i* ]]; then
    get_aws_credentials
fi

#!/bin/bash
# AWS凭证自动获取脚本

# 自动配置Builder-MCP符号链接
setup_builder_mcp() {
    # 改进的用户检测逻辑
    local wsl_user=$(whoami)
    local windows_user=""
    
    if [[ -d "/mnt/c/Users/$wsl_user" ]]; then
        windows_user="$wsl_user"
    else
        windows_user=$(ls /mnt/c/Users/ | grep -v "^Public$\|^Default\|^All Users$\|^Administrator$\|^Guest$" | head -1)
    fi
    
    # 创建符号链接
    mkdir -p ~/.midway
    if [[ ! -L ~/.midway/cookie ]] || [[ ! -e ~/.midway/cookie ]]; then
        rm -f ~/.midway/cookie
        ln -sf "/mnt/c/Users/$windows_user/.midway/cookie" ~/.midway/cookie
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

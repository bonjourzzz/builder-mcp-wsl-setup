# Builder-MCP WSL自动认证方案

## 🎯 问题背景
Builder-MCP是Amazon内部工具，需要在WSL环境中配置认证才能使用。主要问题：
1. WSL无法直接运行Windows的`mwinit`认证命令
2. WSL环境下SSL证书验证会失败
3. 需要共享Windows的认证cookie到WSL

## 🚀 一键自动化解决方案（最新版）

### 核心思路
通过一个自动执行脚本，在每次WSL启动时自动完成所有配置，包括：
- 智能检测正确的Windows用户
- **复制Windows认证cookie到WSL**（而非符号链接）
- 跳过SSL验证获取AWS凭证
- **多终端进程隔离**

### AI执行步骤

#### 1. 安装自动认证脚本
**AI需要执行以下命令**，将 `3-自动认证脚本.sh` 安装到系统：

```bash
sudo cp 3-自动认证脚本.sh /etc/profile.d/aws-credentials.sh
sudo chmod +x /etc/profile.d/aws-credentials.sh
```

#### 2. 验证安装
**AI需要执行验证命令**：
```bash
ls -la /etc/profile.d/aws-credentials.sh
```

安装成功后，告知用户完成Windows认证步骤。

## 📋 用户使用流程

### 一次性设置（每台机器只需一次）
1. **安装上述脚本到WSL**
2. **在Windows PowerShell运行认证**：
   ```powershell
   mwinit
   ```

### 日常使用
1. **打开WSL终端**（脚本自动执行配置）
2. **直接使用Builder-MCP**：
   ```bash
   q
   ```

## 🔧 方案优势

### 自动化程度高
- ✅ 每次WSL启动自动配置
- ✅ 自动检测正确的Windows用户
- ✅ **自动复制Windows认证cookie**
- ✅ 自动跳过SSL验证
- ✅ **多终端进程隔离** - 每个WSL终端的curl进程独立工作

### 智能用户检测
- ✅ 优先使用WSL用户名匹配Windows用户
- ✅ 排除系统用户（Administrator、Guest等）
- ✅ 避免用户检测错误

### 维护成本低
- ✅ 无需手动维护配置
- ✅ 无需担心认证冲突
- ✅ 认证过期时只需重新运行`mwinit`
- ✅ **无限制多终端使用** - 可同时打开任意数量WSL终端
- ✅ **进程级隔离** - 各终端curl进程互不影响

## 🚨 故障排除

### 问题1：认证失效
**现象**：builder-mcp提示认证失败
**解决**：在Windows PowerShell重新运行 `mwinit`

### 问题2：脚本未生效
**现象**：WSL启动时没有看到认证信息
**解决**：
```bash
# 检查脚本是否存在
ls -la /etc/profile.d/aws-credentials.sh

# 重新打开WSL终端
```

### 问题3：权限问题
**现象**：脚本安装失败
**解决**：
```bash
sudo usermod -aG sudo $USER
# 然后重新登录WSL
```

## 🎯 技术原理

### Cookie复制机制（最新改进）
- **每次WSL启动时复制Windows cookie到WSL**
- **进程隔离**：每个WSL终端的curl进程独立工作，共享同一cookie文件
- **Windows保护**：原始Windows认证永远不被修改
- **多终端支持**：无限制同时使用多个WSL终端

### SSL验证跳过
- 使用`curl -k`参数跳过SSL证书验证
- 直接从Midway服务获取临时AWS凭证

### Cookie处理机制
- **复制策略**：`cp` Windows cookie到WSL，而非符号链接
- **完整读写**：保持`-c`和`-b`参数，确保builder-mcp正常工作
- **隔离保护**：WSL中的cookie操作不影响Windows原始认证

### 自动执行机制
- 脚本放在`/etc/profile.d/`目录
- 每次交互式shell启动时自动执行

## 📝 总结

这套方案实现了Builder-MCP在WSL中的完全自动化认证：
- **用户只需一次性安装脚本**
- **日常使用只需在Windows运行`mwinit`**
- **所有WSL端配置完全自动化**
- **无需手动维护任何配置文件**

适用于所有需要在WSL中使用Builder-MCP的Amazon员工。

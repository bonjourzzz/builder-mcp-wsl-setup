# Builder-MCP WSL自动配置方案 ESM-NRHZ-Alan

🚀 **一键配置Amazon Builder-MCP在WSL环境中的自动认证**

## 📁 文件说明

- **1-用户操作指南-先看这个.md** - 用户使用指南（3步完成配置）
- **2-技术文档-给AI参考.md** - AI执行的技术实现细节
- **3-自动认证脚本.sh** - 自动认证脚本文件

## 🎯 解决的问题

- WSL无法直接运行Windows的`mwinit`认证命令
- WSL环境下SSL证书验证失败
- 需要共享Windows认证cookie到WSL

## ⚡ 快速开始

### 用户操作（超简单）

1. **下载所有文件到本地**
2. **对AI说**：
   ```
   请阅读 "2-技术文档-给AI参考.md" 文件，并按照其中的安装步骤自动执行所有配置操作
   ```
3. **在Windows PowerShell运行**：
   ```powershell
   mwinit
   ```
4. **重新打开WSL终端，运行**：
   ```bash
   q
   ```

### 成功标志
- WSL启动时显示：`✓ AWS验证成功`
- 运行`q`命令能正常启动Builder-MCP

## 🔧 技术原理

- **自动符号链接**：智能检测Windows用户，创建认证cookie共享
- **SSL验证跳过**：绕过WSL环境SSL证书问题
- **开机自启**：每次WSL启动自动配置和验证

## 🎯 适用对象

- Amazon员工需要在WSL中使用Builder-MCP
- 希望自动化认证配置的开发者
- 需要AI辅助配置的用户

## 📝 贡献

欢迎提交Issue和Pull Request改进这个配置方案。

## 📄 许可证

MIT License

---

**让AI帮你3步完成Builder-MCP WSL配置！**

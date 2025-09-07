# Builder-MCP WSL自动配置方案 ESM-NRHZ-Alan

🚀 **一键配置Amazon Builder-MCP在WSL环境中的自动认证**

## 📁 文件说明

- **1-用户操作指南-先看这个.md** - 用户使用指南（3步完成配置）
- **2-技术文档-给AI参考.md** - AI执行的技术实现细节
- **3-自动认证脚本.sh** - 自动认证脚本文件

## 🎯 解决的问题

- WSL无法直接运行Windows的`mwinit`认证命令
- WSL环境下SSL证书验证失败
- 多终端认证进程冲突问题
- Windows认证被WSL覆盖的问题

## 🔧 技术原理

- **Cookie复制机制**：每次WSL启动时复制Windows认证到WSL
- **进程隔离**：每个WSL终端的curl进程独立工作，共享同一cookie文件
- **Windows保护**：原始Windows认证永远不被修改
- **SSL验证跳过**：绕过WSL环境SSL证书问题
- **多终端支持**：可同时打开任意数量WSL终端

## 🎯 适用对象

- Amazon员工需要在WSL中使用Builder-MCP
- 希望自动化认证配置的开发者
- 需要AI辅助配置的用户

---

**详细使用方法请查看"1-用户操作指南-先看这个.md"**

# 🏠 HomeBox - 智能家庭收纳助手

> AI-powered home inventory management app - 拍照即可记录，对话即可查找

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20Android-lightgrey.svg)](https://github.com/huweiopenclaw/homebox)

## ✨ 功能特性

- 📸 **拍照识别** - 拍摄箱内物品，AI 自动识别并记录
- 📍 **位置记忆** - 拍摄存放位置，AI 描述具体位置
- 💬 **对话查询** - 自然语言问询，快速找到物品
- 🔍 **智能搜索** - 按物品名、房间、类别搜索
- 📱 **离线支持** - 本地存储，随时可查

## 📖 文档

- [产品需求文档 (PRD)](./PRD.md)
- [技术设计文档](./DESIGN.md)

## 🛠 技术栈

| 类别 | 技术 |
|------|------|
| 移动端 | Flutter |
| 后端 | Python FastAPI |
| 数据库 | PostgreSQL + SQLite |
| AI | GLM-4V / Claude 3 |
| 存储 | 阿里云 OSS |

## 🚀 快速开始

### 环境要求

- Flutter 3.16+
- Python 3.11+
- PostgreSQL 15+

### 后端启动

```bash
cd backend
pip install -r requirements.txt
uvicorn app.main:app --reload
```

### 移动端启动

```bash
cd app
flutter pub get
flutter run
```

## 📁 项目结构

```
homebox/
├── app/                    # Flutter 移动端
│   ├── lib/
│   │   ├── features/       # 功能模块
│   │   ├── core/           # 核心模块
│   │   └── shared/         # 共享组件
│   └── pubspec.yaml
├── backend/                # FastAPI 后端
│   ├── app/
│   │   ├── api/            # API 路由
│   │   ├── models/         # 数据模型
│   │   ├── services/       # 业务服务
│   │   └── schemas/        # Pydantic 模型
│   └── requirements.txt
├── PRD.md                  # 产品需求文档
├── DESIGN.md               # 技术设计文档
└── README.md
```

## 🗓 开发计划

| 阶段 | 时间 | 目标 |
|------|------|------|
| MVP | 4周 | 核心功能可用 |
| Beta | 8周 | 完整功能，小范围测试 |
| V1.0 | 12周 | 正式上线 |

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

[MIT License](LICENSE)

---

**Made with ❤️ by [huweiopenclaw](https://github.com/huweiopenclaw)**

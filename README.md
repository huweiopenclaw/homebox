# HomeBox - 智能家庭收纳助手

## 开发进度

| 模块 | 状态 | 完成度 |
|------|------|--------|
| 后端 API (FastAPI) | ✅ 完成 | 100% |
| Flutter App UI | ✅ 完成 | 100% |
| Android 配置 | ✅ 完成 | 100% |
| iOS 配置 | ✅ 完成 | 100% |
| 鸿蒙配置 | ✅ 配置完成 | 100% |
| 单元测试 | ✅ 完成 | 100% |
| Flutter SDK 安装 | ⏳ 进行中 | - |
| 完整编译测试 | ⏳ 待完成 | - |

## 项目结构

```
homebox/
├── app/                          # Flutter 移动端
│   ├── lib/
│   │   ├── main.dart             # 应用入口
│   │   ├── core/                 # 核心模块
│   │   │   ├── network/          # API 客户端
│   │   │   ├── router/           # 路由配置
│   │   │   └── theme/            # 主题系统
│   │   └── features/             # 功能模块
│   │       ├── auth/             # 认证
│   │       ├── box/              # 箱子管理
│   │       ├── chat/             # 对话查询
│   │       ├── home/             # 首页
│   │       └── settings/         # 设置
│   ├── android/                  # Android 配置
│   ├── ios/                      # iOS 配置
│   ├── ohos/                     # 鸿蒙配置
│   ├── test/                     # 单元测试
│   └── integration_test/         # 集成测试
│
├── backend/                      # FastAPI 后端
│   ├── app/
│   │   ├── main.py               # 应用入口
│   │   ├── api/v1/               # API 路由
│   │   │   ├── auth.py           # 认证接口
│   │   │   ├── boxes.py          # 箱子接口
│   │   │   ├── ai.py             # AI 识别接口
│   │   │   └── chat.py           # 对话接口
│   │   ├── models/               # 数据模型
│   │   ├── schemas/              # Pydantic 模型
│   │   ├── services/             # 业务服务
│   │   │   ├── ai_service.py     # VLM 集成
│   │   │   └── storage_service.py
│   │   └── repositories/         # 数据访问层
│   ├── tests/                    # 测试
│   ├── Dockerfile
│   └── docker-compose.yml
│
├── PRD.md                        # 产品需求文档
├── DESIGN.md                     # 技术设计文档
└── README.md                     # 项目说明
```

## 快速开始

### 环境要求

- Flutter SDK 3.16+
- Python 3.11+
- PostgreSQL 15+ (可选，开发可用 SQLite)

### 后端启动

```bash
cd backend

# 安装依赖
pip install -r requirements.txt

# 启动开发服务器
uvicorn app.main:app --reload

# API 文档: http://localhost:8000/docs
```

### 移动端启动

```bash
cd app

# 安装依赖
flutter pub get

# 运行 (需要连接设备或模拟器)
flutter run

# 构建 APK
flutter build apk

# 构建 iOS
flutter build ios

# 构建鸿蒙 (需要 DevEco Studio)
# 参考: https://docs.openharmony.cn/
```

## 核心功能

### 1. 拍照识别
- 拍摄箱内物品
- VLM 自动识别物品类型和数量
- 支持手动修改识别结果

### 2. 位置记录
- 拍摄箱子存放位置
- AI 识别房间、家具、位置
- 自动生成位置描述

### 3. 对话查询
- 自然语言查询物品位置
- "我的围巾在哪？"
- AI 智能回答

## API 接口

| 接口 | 方法 | 描述 |
|------|------|------|
| `/api/v1/auth/register` | POST | 用户注册 |
| `/api/v1/auth/login` | POST | 用户登录 |
| `/api/v1/boxes` | GET/POST | 箱子列表/创建 |
| `/api/v1/boxes/{id}` | GET/PUT/DELETE | 箱子详情/更新/删除 |
| `/api/v1/ai/recognize-items` | POST | AI 物品识别 |
| `/api/v1/ai/recognize-location` | POST | AI 位置识别 |
| `/api/v1/chat` | POST | 对话查询 |

## 技术栈

| 层级 | 技术 |
|------|------|
| 移动端 | Flutter 3.27 |
| 状态管理 | Riverpod |
| 后端 | Python FastAPI |
| 数据库 | PostgreSQL / SQLite |
| VLM | GLM-4V / Claude 3 |
| 存储 | 阿里云 OSS |

## 开发计划

| 阶段 | 时间 | 目标 | 状态 |
|------|------|------|------|
| Phase 1 | 4周 | 后端 + Flutter UI | ✅ 完成 |
| Phase 2 | 2周 | AI 集成 + 测试 | ⏳ 进行中 |
| Phase 3 | 2周 | iOS/Android 编译测试 | ⏳ 待完成 |
| Phase 4 | 2周 | 鸿蒙适配 + 发布 | ⏳ 待完成 |

---

**GitHub**: https://github.com/huweiopenclaw/homebox

**Made with ❤️ by HOC**

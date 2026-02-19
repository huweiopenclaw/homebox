# HomeBox - 技术设计文档

**版本**: 1.0
**日期**: 2026-02-19
**作者**: HOC & 主人

---

## 1. 系统架构

### 1.1 整体架构图

```
┌─────────────────────────────────────────────────────────────────┐
│                         客户端 (Mobile App)                       │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │   UI 层     │  │  业务逻辑层  │  │  本地存储层  │              │
│  │  (Screens)  │  │  (BLoC/VM)  │  │  (SQLite)   │              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                         API Gateway                              │
│                    (Kong / AWS API Gateway)                      │
└─────────────────────────────────────────────────────────────────┘
                              │
          ┌───────────────────┼───────────────────┐
          ▼                   ▼                   ▼
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│   User Service  │  │   Box Service   │  │   AI Service    │
│   (用户服务)     │  │   (箱子服务)     │  │   (AI服务)      │
└─────────────────┘  └─────────────────┘  └─────────────────┘
          │                   │                   │
          └───────────────────┼───────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                         数据层                                    │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │ PostgreSQL  │  │    Redis    │  │  对象存储    │              │
│  │  (主数据库)  │  │   (缓存)    │  │  (S3/OSS)   │              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      外部服务                                     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │   VLM API   │  │   LLM API   │  │   推送服务   │              │
│  │ (视觉模型)   │  │ (对话模型)   │  │  (FCM/APNS) │              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
└─────────────────────────────────────────────────────────────────┘
```

### 1.2 技术栈选型

| 层级 | 技术选型 | 备选方案 | 理由 |
|------|----------|----------|------|
| **移动端** | Flutter | React Native | 跨平台一致性、性能好、开发效率高 |
| **后端** | Python FastAPI | Node.js / Go | AI 生态丰富、开发快速 |
| **数据库** | PostgreSQL + SQLite | MySQL / MongoDB | PG 功能全面，SQLite 本地支持好 |
| **缓存** | Redis | Memcached | 支持多种数据结构 |
| **对象存储** | 阿里云 OSS | AWS S3 | 国内访问快 |
| **VLM** | GLM-4V / Claude 3 | GPT-4V | 中文识别好、成本可控 |
| **LLM** | GLM-4 / Claude 3 | GPT-4 | 对话生成质量高 |
| **消息队列** | Redis Streams | RabbitMQ | 简单场景够用 |
| **部署** | Docker + K8s | Serverless | 可扩展性好 |

---

## 2. 模块设计

### 2.1 移动端架构 (Flutter)

```
lib/
├── app/
│   ├── main.dart                 # 应用入口
│   └── app_router.dart           # 路由配置
├── core/
│   ├── constants/                # 常量定义
│   ├── theme/                    # 主题配置
│   ├── utils/                    # 工具函数
│   └── network/                  # 网络层封装
├── features/
│   ├── auth/                     # 认证模块
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── box/                      # 箱子管理
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── repositories/
│   │   │   └── datasources/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   ├── camera/                   # 拍照模块
│   ├── chat/                     # 对话查询模块
│   └── settings/                 # 设置模块
├── shared/
│   ├── widgets/                  # 共享组件
│   └── services/                 # 共享服务
└── l10n/                         # 国际化
```

### 2.2 后端架构 (FastAPI)

```
backend/
├── app/
│   ├── main.py                   # 应用入口
│   ├── config.py                 # 配置管理
│   ├── api/
│   │   ├── v1/
│   │   │   ├── auth.py           # 认证接口
│   │   │   ├── boxes.py          # 箱子接口
│   │   │   ├── items.py          # 物品接口
│   │   │   ├── chat.py           # 对话接口
│   │   │   └── ai.py             # AI 接口
│   │   └── deps.py               # 依赖注入
│   ├── core/
│   │   ├── security.py           # 安全相关
│   │   ├── config.py             # 配置
│   │   └── logging.py            # 日志
│   ├── models/                   # 数据库模型
│   │   ├── user.py
│   │   ├── box.py
│   │   └── item.py
│   ├── schemas/                  # Pydantic 模型
│   │   ├── user.py
│   │   ├── box.py
│   │   └── chat.py
│   ├── services/
│   │   ├── ai_service.py         # AI 服务封装
│   │   ├── storage_service.py    # 存储服务
│   │   └── cache_service.py      # 缓存服务
│   └── repositories/             # 数据访问层
├── alembic/                      # 数据库迁移
├── tests/                        # 测试
├── Dockerfile
└── docker-compose.yml
```

---

## 3. 核心功能设计

### 3.1 物品识别流程

```
┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
│  拍照   │ -> │  压缩   │ -> │  上传   │ -> │ VLM分析 │ -> │ 返回结果 │
└─────────┘    └─────────┘    └─────────┘    └─────────┘    └─────────┘
     │              │              │              │              │
     │              │              │              │              │
     ▼              ▼              ▼              ▼              ▼
  Camera API    压缩到        OSS 上传      GLM-4V API     JSON 解析
  获取图片      1MB 以内      获取 URL      带图片请求    结构化数据
```

**VLM Prompt 设计：**

```
你是一个家庭收纳助手。请分析这张照片中的物品，返回 JSON 格式的物品列表。

要求：
1. 识别所有可见物品
2. 估计每个物品的数量
3. 用中文描述物品名称
4. 如果有颜色，在名称中包含

返回格式：
{
  "items": [
    {"name": "红色毛衣", "quantity": 2, "confidence": 0.95},
    {"name": "灰色围巾", "quantity": 1, "confidence": 0.90}
  ],
  "summary": "箱子中包含冬季衣物，共4件"
}
```

### 3.2 位置识别流程

**VLM Prompt 设计：**

```
你是一个家庭收纳助手。请分析这张照片，描述箱子/物品的存放位置。

要求：
1. 识别房间类型（卧室/客厅/厨房/浴室/储藏室/阳台）
2. 识别家具（衣柜/书架/抽屉/箱子/床底）
3. 描述具体位置（左/右/上/下/中层）
4. 尽量具体但简洁

返回格式：
{
  "room": "卧室",
  "furniture": "衣柜",
  "position": "左侧顶层",
  "description": "卧室衣柜左侧顶层",
  "landmarks": ["窗边", "床头柜旁边"]
}
```

### 3.3 对话查询系统

```
┌─────────────────────────────────────────────────────────────────┐
│                       对话查询架构                               │
│                                                                  │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐  │
│  │ 用户问题 │ -> │ 意图识别 │ -> │ 实体抽取 │ -> │ 数据检索 │  │
│  │          │    │          │    │          │    │          │  │
│  └──────────┘    └──────────┘    └──────────┘    └──────────┘  │
│                                                       │         │
│                                                       ▼         │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐  │
│  │ 返回答案 │ <- │ 答案生成 │ <- │ 上下文   │ <- │ 结果排序 │  │
│  │          │    │          │    │ 构建     │    │          │  │
│  └──────────┘    └──────────┘    └──────────┘    └──────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

**意图类型：**

| 意图 | 示例 | 处理方式 |
|------|------|----------|
| 查找物品 | "我的围巾在哪？" | 搜索 items，返回位置 |
| 列出箱子 | "卧室有哪些箱子？" | 按房间过滤 boxes |
| 统计数量 | "我有多少件毛衣？" | 聚合统计 items |
| 添加物品 | "箱子1里还有一个帽子" | 更新 box items |
| 删除物品 | "围巾已经拿出来了" | 删除/标记物品 |
| 一般聊天 | "你好" / "谢谢" | LLM 闲聊 |

**RAG 检索流程：**

```python
async def chat_query(user_id: str, question: str):
    # 1. 意图识别
    intent = await llm.classify_intent(question)
    
    # 2. 实体抽取
    entities = await llm.extract_entities(question)
    # entities = {"item": "围巾", "room": None, ...}
    
    # 3. 数据库检索
    if intent == "find_item":
        boxes = await db.query_boxes(
            user_id=user_id,
            item_name=entities.get("item")
        )
    
    # 4. 构建上下文
    context = build_context(boxes, entities)
    
    # 5. LLM 生成答案
    answer = await llm.generate_answer(
        question=question,
        context=context,
        intent=intent
    )
    
    return answer
```

---

## 4. 数据库设计

### 4.1 ER 图

```
┌─────────────┐       ┌─────────────┐       ┌─────────────┐
│    users    │       │    boxes    │       │    items    │
├─────────────┤       ├─────────────┤       ├─────────────┤
│ id          │───┐   │ id          │───┐   │ id          │
│ email       │   │   │ user_id     │   │   │ box_id      │
│ password    │   └──>│ name        │   └──>│ name        │
│ created_at  │       │ category    │       │ quantity    │
│ updated_at  │       │ room        │       │ note        │
└─────────────┘       │ furniture   │       │ expiry_date │
                      │ position    │       │ created_at  │
                      │ item_photo  │       │ updated_at  │
                      │ loc_photo   │       └─────────────┘
                      │ created_at  │
                      │ updated_at  │
                      └─────────────┘
                      
┌─────────────┐       ┌─────────────┐
│chat_sessions│       │chat_messages│
├─────────────┤       ├─────────────┤
│ id          │───┐   │ id          │
│ user_id     │   └──>│ session_id  │
│ title       │       │ role        │
│ created_at  │       │ content     │
│ updated_at  │       │ created_at  │
└─────────────┘       └─────────────┘
```

### 4.2 表结构详细设计

**users 表**
```sql
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    nickname VARCHAR(100),
    avatar_url TEXT,
    subscription_tier VARCHAR(20) DEFAULT 'free', -- free, premium, lifetime
    subscription_expires_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**boxes 表**
```sql
CREATE TABLE boxes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100), -- 衣物、书籍、杂物等
    
    -- 位置信息
    room VARCHAR(100),
    furniture VARCHAR(100),
    position VARCHAR(100),
    location_description TEXT,
    
    -- 照片
    item_photo_url TEXT,
    loc_photo_url TEXT,
    
    -- AI 识别结果缓存
    item_recognition JSONB,
    location_recognition JSONB,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- 索引优化
    CONSTRAINT valid_category CHECK (category IN ('衣物', '书籍', '电子产品', '厨房用品', '杂物', '其他'))
);

CREATE INDEX idx_boxes_user_id ON boxes(user_id);
CREATE INDEX idx_boxes_room ON boxes(room);
CREATE INDEX idx_boxes_category ON boxes(category);
```

**items 表**
```sql
CREATE TABLE items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    box_id UUID NOT NULL REFERENCES boxes(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    quantity INTEGER DEFAULT 1,
    note TEXT,
    expiry_date DATE,
    
    -- AI 置信度
    confidence FLOAT,
    
    -- 是否被用户修改过
    user_modified BOOLEAN DEFAULT FALSE,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_items_box_id ON items(box_id);
CREATE INDEX idx_items_name ON items USING gin(to_tsvector('simple', name));
```

**chat_messages 表**
```sql
CREATE TABLE chat_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE chat_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id UUID NOT NULL REFERENCES chat_sessions(id) ON DELETE CASCADE,
    role VARCHAR(20) NOT NULL, -- user, assistant
    content TEXT NOT NULL,
    
    -- 关联的箱子（查询结果）
    related_boxes UUID[],
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_chat_messages_session_id ON chat_messages(session_id);
```

---

## 5. API 设计

### 5.1 RESTful API

**认证相关**
```
POST   /api/v1/auth/register      # 注册
POST   /api/v1/auth/login         # 登录
POST   /api/v1/auth/logout        # 登出
POST   /api/v1/auth/refresh       # 刷新 Token
GET    /api/v1/auth/me            # 获取当前用户信息
```

**箱子管理**
```
GET    /api/v1/boxes              # 获取箱子列表
POST   /api/v1/boxes              # 创建新箱子
GET    /api/v1/boxes/{id}         # 获取箱子详情
PUT    /api/v1/boxes/{id}         # 更新箱子信息
DELETE /api/v1/boxes/{id}         # 删除箱子
GET    /api/v1/boxes/search       # 搜索箱子
```

**物品管理**
```
GET    /api/v1/boxes/{box_id}/items    # 获取箱子内物品
POST   /api/v1/boxes/{box_id}/items    # 添加物品
PUT    /api/v1/items/{id}              # 更新物品
DELETE /api/v1/items/{id}              # 删除物品
```

**AI 识别**
```
POST   /api/v1/ai/recognize-items      # 识别箱内物品
POST   /api/v1/ai/recognize-location   # 识别存放位置
```

**对话查询**
```
POST   /api/v1/chat                     # 发送消息（流式响应）
GET    /api/v1/chat/sessions            # 获取会话列表
GET    /api/v1/chat/sessions/{id}       # 获取会话历史
DELETE /api/v1/chat/sessions/{id}       # 删除会话
```

### 5.2 API 请求/响应示例

**创建箱子**
```json
// POST /api/v1/boxes
// Request
{
  "name": "冬季衣物-1",
  "category": "衣物",
  "item_photo": "base64_encoded_image",
  "loc_photo": "base64_encoded_image",
  "auto_recognize": true
}

// Response
{
  "id": "box_abc123",
  "name": "冬季衣物-1",
  "category": "衣物",
  "location": {
    "room": "卧室",
    "furniture": "衣柜",
    "position": "左侧顶层",
    "description": "卧室衣柜左侧顶层"
  },
  "items": [
    {"name": "红色毛衣", "quantity": 2},
    {"name": "灰色围巾", "quantity": 1}
  ],
  "item_photo_url": "https://...",
  "loc_photo_url": "https://...",
  "created_at": "2026-02-19T21:00:00Z"
}
```

**对话查询**
```json
// POST /api/v1/chat
// Request
{
  "session_id": "session_xyz",
  "message": "我的围巾在哪？"
}

// Response (SSE Stream)
data: {"type": "thinking", "content": "正在查找..."}
data: {"type": "result", "boxes": [{"id": "box_abc123", "name": "冬季衣物-1"}]}
data: {"type": "answer", "content": "您的围巾在【冬季衣物-1】箱子中，位于卧室衣柜左侧顶层。"}
data: {"type": "done"}
```

---

## 6. 安全设计

### 6.1 认证与授权
- JWT Token 认证
- Access Token: 15分钟有效期
- Refresh Token: 7天有效期
- Token 存储在 Secure Storage

### 6.2 数据安全
- 密码使用 bcrypt 加密
- 敏感数据传输使用 HTTPS
- 照片 URL 使用签名链接（有时效）
- 本地数据库加密 (SQLCipher)

### 6.3 隐私保护
- 照片可选择不上传云端
- 支持数据导出和删除
- 遵循 GDPR 规范

---

## 7. 性能优化

### 7.1 图片优化
- 上传前压缩到 1MB 以内
- 使用 WebP 格式
- 缩略图生成（200x200）

### 7.2 缓存策略
- 热点数据 Redis 缓存（TTL 1小时）
- 本地 SQLite 缓存箱子列表
- 图片本地缓存

### 7.3 AI 请求优化
- 批量请求合并
- 结果缓存（相同图片不重复识别）
- 流式响应提升体验

---

## 8. 部署架构

### 8.1 开发环境
```yaml
# docker-compose.yml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "8000:8000"
    depends_on:
      - db
      - redis
    environment:
      - DATABASE_URL=postgresql://user:pass@db:5432/homebox
      - REDIS_URL=redis://redis:6379
      
  db:
    image: postgres:15
    environment:
      POSTGRES_DB: homebox
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
    volumes:
      - pgdata:/var/lib/postgresql/data
      
  redis:
    image: redis:7-alpine
    
volumes:
  pgdata:
```

### 8.2 生产环境
```
┌─────────────────────────────────────────────────────────────────┐
│                          负载均衡器                               │
│                      (阿里云 SLB / Nginx)                        │
└─────────────────────────────────────────────────────────────────┘
                              │
          ┌───────────────────┼───────────────────┐
          ▼                   ▼                   ▼
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│   API Server 1  │  │   API Server 2  │  │   API Server 3  │
│   (FastAPI)     │  │   (FastAPI)     │  │   (FastAPI)     │
└─────────────────┘  └─────────────────┘  └─────────────────┘
          │                   │                   │
          └───────────────────┼───────────────────┘
                              │
          ┌───────────────────┼───────────────────┐
          ▼                   ▼                   ▼
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│   PostgreSQL    │  │     Redis       │  │   阿里云 OSS    │
│   (主从复制)     │  │   (集群模式)    │  │   (对象存储)    │
└─────────────────┘  └─────────────────┘  └─────────────────┘
```

---

## 9. 监控与日志

### 9.1 监控指标
- API 响应时间
- AI 识别成功率
- 错误率
- 并发用户数

### 9.2 日志收集
- 结构化日志 (JSON)
- ELK / 阿里云 SLS
- 错误告警 (Sentry)

---

## 10. 测试策略

### 10.1 单元测试
- 覆盖率 > 80%
- 核心业务逻辑 100% 覆盖

### 10.2 集成测试
- API 端到端测试
- 数据库集成测试

### 10.3 E2E 测试
- Flutter integration_test
- 关键用户流程

---

## 11. 开发计划

### Phase 1: MVP (4周)
- Week 1: 项目搭建、数据库设计、基础 API
- Week 2: 用户认证、箱子 CRUD
- Week 3: AI 识别集成（物品+位置）
- Week 4: 对话查询、Flutter UI 基础

### Phase 2: Beta (4周)
- Week 5-6: UI 完善、离线支持
- Week 7: 性能优化、错误处理
- Week 8: 测试、Bug 修复

### Phase 3: V1.0 (4周)
- Week 9-10: 多设备同步、云端备份
- Week 11: 订阅系统、支付集成
- Week 12: 上架准备、文档完善

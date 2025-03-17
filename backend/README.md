# 答案之书后端应用

## 技术栈
- Python 3.8+
- Flask
- MySQL
- Anaconda

## 目录结构
```
/backend
├── app/
│   ├── __init__.py        # Flask应用初始化
│   ├── models/            # 数据模型
│   ├── routes/            # 路由
│   ├── services/          # 业务逻辑
│   └── utils/             # 工具类
├── config/                # 配置文件
│   ├── __init__.py
│   ├── development.py     # 开发环境配置
│   └── production.py      # 生产环境配置
├── tests/                 # 测试文件
├── requirements.txt       # 依赖配置
└── run.py                 # 应用入口
```

## 开发规范
1. 遵循PEP 8编码规范
2. 使用类型注解
3. 编写单元测试
4. 使用环境变量管理配置

## 主要功能
1. 答案管理API
2. 随机答案获取API
3. 系统配置管理
4. 数据库迁移
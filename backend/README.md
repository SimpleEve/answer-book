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
│   ├── base.yml          # 基础配置
│   ├── development.yml    # 开发环境配置
│   └── production.yml     # 生产环境配置
├── tests/                 # 测试文件
├── requirements.txt       # 依赖配置
└── run.py                 # 应用入口（已弃用，请使用flask命令启动）
```

## 开发规范
1. 遵循PEP 8编码规范
2. 使用类型注解
3. 编写单元测试

## 环境配置
1. 安装依赖
```bash
pip install -r requirements.txt
```

2. 设置环境变量
```bash
# 设置Flask应用
export FLASK_APP=app
# 设置开发环境（可选：development, production）
export FLASK_ENV=development
# 开启调试模式（仅开发环境）
export FLASK_DEBUG=1
```

## 启动应用
```bash
# 启动开发服务器
flask run

# 指定主机和端口
flask run --host=0.0.0.0 --port=5000
```

## API文档
请参考 `/doc/api.md`
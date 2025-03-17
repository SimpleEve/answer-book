# 答案之书应用

## 项目概述
这是一个基于Flutter和Python+Flask的答案之书应用。用户可以通过优雅的翻书动画效果获得随机答案。

## 目录结构
```
/answer-book
├── doc/                # 项目文档
│   ├── README.md      # 项目说明文档
│   ├── progress.md    # 开发进度文档
│   ├── api.md         # API接口文档
│   └── database.md    # 数据字典文档
├── frontend/          # Flutter前端应用
└── backend/           # Python后端应用
    ├── app/           # Flask应用代码
    ├── config/        # 配置文件
    ├── requirements.txt # Python依赖
    └── README.md      # 后端说明文档
```

## 技术选型

### 前端技术栈
- Flutter：跨平台UI框架
- Material Design：UI设计规范

### 后端技术栈
- Python：编程语言
- Flask：Web框架
- MySQL：数据库
- Anaconda：Python环境管理

## 环境要求
- Flutter SDK
- Python 3.8+
- Anaconda
- MySQL 8.0+

## 启动命令

### 后端服务
1. 创建并激活Anaconda环境
```bash
conda create -n answer-book python=3.8
conda activate answer-book
```

2. 安装依赖
```bash
cd backend
pip install -r requirements.txt
```

3. 初始化数据库
```bash
# 使用开发环境配置初始化数据库
python scripts/init_db.py --env development

# 或使用生产环境配置初始化数据库
# python scripts/init_db.py --env production
```

4. 启动Flask服务
```bash
python run.py
```

### 前端应用
1. 安装依赖
```bash
cd frontend
flutter pub get
```

2. 运行应用
```bash
flutter run
```

## 开发规范
1. 代码风格遵循各自语言的官方规范
2. 提交信息需要清晰描述改动内容
3. 重要功能需要编写测试用例
4. API文档及时更新

## 项目进度
详见 [开发进度文档](./progress.md)

## API文档
详见 [API文档](./api.md)

## 数据字典
详见 [数据字典](./database.md)
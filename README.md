# 答案之书应用

## 项目概述
这是一个基于Flutter和Python+Flask的答案之书应用。用户可以通过优雅的翻书动画效果获得随机答案，并且可以对喜欢的答案进行点赞互动。

## 目录结构
```
/answer-book
├── doc/                # 项目文档
│   ├── README.md      # 项目说明文档
│   ├── progress.md    # 开发进度文档
│   ├── api.md         # API接口文档
│   └── database.md    # 数据字典文档
├── frontend/          # Flutter前端应用
│   ├── lib/           # 核心代码目录
│   │   ├── main.dart  # 应用入口文件
│   │   └── services/  # 服务层代码
│   ├── assets/        # 静态资源目录
│   │   ├── fonts/     # 字体文件
│   │   └── images/    # 图片资源
│   ├── test/          # 测试代码
│   └── pubspec.yaml   # 项目配置和依赖
└── backend/           # Python后端应用
    ├── app/           # Flask应用代码
    │   ├── api.py     # API接口实现
    │   └── models.py  # 数据模型
    ├── config/        # 配置文件
    │   ├── base.yml   # 基础配置
    │   ├── development.yml # 开发环境配置
    │   └── production.yml # 生产环境配置
    ├── scripts/       # 脚本工具
    │   └── init_db.py # 数据库初始化脚本
    ├── requirements.txt # Python依赖
    └── README.md      # 后端说明文档
```

## 技术选型

### 前端技术栈
- Flutter：跨平台UI框架
- Material Design：UI设计规范
- 翻书动画：自定义动画效果
- 点赞功能：用户互动体验

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
flask run
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

## API文档
详见 [API文档](doc/api.md)

## 数据字典
详见 [数据字典](doc/database.md)
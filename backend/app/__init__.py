from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from config.config_loader import load_config

db = SQLAlchemy()

def create_app(config_name='development'):
    app = Flask(__name__)
    
    # 加载配置
    config = load_config(config_name)
    app.config.update(config)
    
    # 初始化扩展
    CORS(app)
    db.init_app(app)
    
    # 注册蓝图
    from .api import api_bp
    app.register_blueprint(api_bp, url_prefix='/api/v1')
    
    return app
import os
import yaml
from pathlib import Path

def load_config(config_name=None):
    # 获取当前环境
    env = config_name or os.getenv('FLASK_ENV', 'development')
    config_dir = Path(__file__).parent
    
    # 加载基础配置
    with open(config_dir / 'base.yml', 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    
    # 加载环境特定配置
    env_config_file = config_dir / f'{env}.yml'
    if env_config_file.exists():
        with open(env_config_file, 'r', encoding='utf-8') as f:
            env_config = yaml.safe_load(f)
            
            # 处理继承
            if 'inherit' in env_config:
                del env_config['inherit']
            
            # 递归合并配置
            def deep_merge(base, override):
                for key, value in override.items():
                    if isinstance(value, dict) and key in base and isinstance(base[key], dict):
                        deep_merge(base[key], value)
                    else:
                        base[key] = value
            
            # 合并配置
            deep_merge(config, env_config)
            
            # 处理SQLAlchemy配置
            if 'sqlalchemy' in config and 'database_uri' in config['sqlalchemy']:
                config['SQLALCHEMY_DATABASE_URI'] = config['sqlalchemy']['database_uri']
                del config['sqlalchemy']
            
            deep_merge(config, env_config)
    
    return config
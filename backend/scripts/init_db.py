import os
import sys
import argparse
import yaml
from pathlib import Path
from sqlalchemy import create_engine, text
from sqlalchemy.orm import Session

def load_config(env):
    config_dir = Path(__file__).parent.parent / 'config'
    config_file = config_dir / f'{env}.yml'
    
    if not config_file.exists():
        print(f"Error: Configuration file {config_file} not found")
        sys.exit(1)
    
    with open(config_file, 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)
    
    return config

def read_answers():
    answers_file = Path(__file__).parent / 'answers'

    print(answers_file.absolute())
    
    if not answers_file.exists():
        print(f"Error: Answers file {answers_file} not found")
        sys.exit(1)
    
    with open(answers_file, 'r', encoding='utf-8') as f:
        return [line.strip() for line in f if line.strip()]

def init_database(config, answers):
    try:
        # 解析数据库URI以获取数据库名称
        db_uri = config['sqlalchemy']['database_uri']
        db_name = db_uri.split('/')[-1]
        
        # 创建不带数据库名的URI用于初始连接
        base_uri = '/'.join(db_uri.split('/')[:-1])
        
        # 连接到MySQL服务器
        engine = create_engine(base_uri)
        with Session(engine) as session:
            # 创建数据库
            session.execute(text(f"CREATE DATABASE IF NOT EXISTS {db_name}"))
            session.commit()
        
        # 重新连接到新创建的数据库
        engine = create_engine(db_uri)
        with Session(engine) as session:
            # 创建answers表
            # 创建表
            session.execute(text("""
            CREATE TABLE IF NOT EXISTS answers (
                id INT AUTO_INCREMENT PRIMARY KEY,
                content VARCHAR(500) NOT NULL,
                likes INT DEFAULT 0,
                created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
            );
            """))
            
            # 创建索引
            # 检查索引是否存在
            index_exists = session.execute(text("""
                SELECT COUNT(*) 
                FROM information_schema.statistics 
                WHERE table_schema = :db_name 
                AND table_name = 'answers' 
                AND index_name = 'idx_created_at'
            """), {"db_name": db_name}).scalar()
            
            if not index_exists:
                session.execute(text("CREATE INDEX idx_created_at ON answers(created_at)"))
            
            # 插入答案数据
            for answer in answers:
                session.execute(
                    text("INSERT INTO answers (content, likes, created_at, updated_at) VALUES (:content, :likes, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)"),
                    {"content": answer, "likes": 0}
                )
            
            session.commit()
            print(f"Successfully initialized database with {len(answers)} answers")
        
    except Exception as err:
        print(f"Error: {err}")
        sys.exit(1)

def main():
    parser = argparse.ArgumentParser(description='Initialize database with answers')
    parser.add_argument('--env', choices=['development', 'production'],
                      default='development', help='Environment configuration to use')
    args = parser.parse_args()
    
    config = load_config(args.env)
    answers = read_answers()
    init_database(config, answers)

if __name__ == '__main__':
    main()
# 数据字典

## 答案表（answers）

### 表说明
存储答案之书中的所有答案内容

### 表结构
| 字段名 | 类型 | 长度 | 允许空 | 默认值 | 说明 |
|--------|------|------|--------|--------|------|
| id | int | 11 | 否 | 自增 | 主键ID |
| content | varchar | 500 | 否 | 无 | 答案内容 |
| likes | int | 11 | 否 | 0 | 点赞数 |
| created_at | datetime | - | 否 | CURRENT_TIMESTAMP | 创建时间 |
| updated_at | datetime | - | 否 | CURRENT_TIMESTAMP | 更新时间 |

### 索引
| 索引名 | 类型 | 字段 | 说明 |
|--------|------|------|------|
| PRIMARY | 主键 | id | 主键索引 |
| idx_created_at | 普通 | created_at | 创建时间索引 |

### 示例数据
```sql
INSERT INTO answers (content) VALUES
('相信你的直觉'),
('现在就行动'),
('等待更好的时机'),
('保持耐心');
```

## 系统配置表（configs）

### 表说明
存储系统配置信息

### 表结构
| 字段名 | 类型 | 长度 | 允许空 | 默认值 | 说明 |
|--------|------|------|--------|--------|------|
| id | int | 11 | 否 | 自增 | 主键ID |
| key | varchar | 50 | 否 | 无 | 配置键名 |
| value | varchar | 200 | 是 | null | 配置值 |
| description | varchar | 200 | 是 | null | 配置说明 |
| created_at | datetime | - | 否 | CURRENT_TIMESTAMP | 创建时间 |
| updated_at | datetime | - | 否 | CURRENT_TIMESTAMP | 更新时间 |

### 索引
| 索引名 | 类型 | 字段 | 说明 |
|--------|------|------|------|
| PRIMARY | 主键 | id | 主键索引 |
| uk_key | 唯一 | key | 键名唯一索引 |

### 示例数据
```sql
INSERT INTO configs (key, value, description) VALUES
('answer_display_time', '5', '答案显示时间（秒）'),
('max_answers_per_day', '10', '每日最大获取答案次数'),
('maintenance_mode', 'false', '系统维护模式');
```
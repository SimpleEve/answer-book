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
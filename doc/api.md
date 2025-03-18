# API文档

## 基础信息
- 基础URL：`http://localhost:5000/api/v1`
- 响应格式：JSON
- 认证方式：无需认证

## 错误码
| 错误码 | 描述 |
|--------|------|
| 200 | 成功 |
| 400 | 请求参数错误 |
| 404 | 资源不存在 |
| 500 | 服务器内部错误 |

## API列表

### 1. 获取随机答案

#### 请求信息
- 方法：`GET`
- 路径：`/answers/random`
- 参数：无

#### 响应信息
```json
{
    "code": 200,
    "message": "success",
    "data": {
        "id": 1,
        "content": "答案内容",
        "likes": 0,
        "created_at": "2024-01-01 12:00:00"
    }
}
```

### 2. 添加答案

#### 请求信息
- 方法：`POST`
- 路径：`/answers`
- 请求体：
```json
{
    "content": "答案内容",
    "category": "分类"
}
```

#### 响应信息
```json
{
    "code": 200,
    "message": "success",
    "data": {
        "id": 1,
        "content": "答案内容",
        "likes": 0,
        "created_at": "2024-01-01 12:00:00"
    }
}
```

### 3. 点赞答案

#### 请求信息
- 方法：`POST`
- 路径：`/answers/{id}/like`
- 参数：无

#### 响应信息
```json
{
    "code": 200,
    "message": "success",
    "data": {
        "id": 1,
        "content": "答案内容",
        "likes": 1,
        "created_at": "2024-01-01 12:00:00"
    }
}
```
from flask import Blueprint, jsonify
from sqlalchemy.sql.expression import func
from .models import Answer

api_bp = Blueprint('api', __name__)

@api_bp.route('/answers/random', methods=['GET'])
def get_random_answer():
    try:
        # 从数据库随机获取一条答案
        answer = Answer.query.order_by(func.random()).first()
        
        if not answer:
            return jsonify({
                'code': 404,
                'message': '没有找到答案',
                'data': None
            })
        
        return jsonify({
            'code': 200,
            'message': 'success',
            'data': answer.to_dict()
        })
        
    except Exception as e:
        return jsonify({
            'code': 500,
            'message': str(e),
            'data': None
        }), 500
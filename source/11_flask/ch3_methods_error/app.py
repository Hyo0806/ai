# 파일명이 app.py일 경우 실행 : flask run --port 80(다른 포트번호와 겹치지 않는 선에서 바꿔도 상관없음) --debug

from flask import Flask, render_template, request
from models import Member
from filters import mask_password

# 앱서버 초기화 세트
app = Flask(__name__)
app.template_filter('mask_pw')(mask_password) # 필터추가

@app.errorhandler(404) # 예외 페이지 처리
def errorhandler(error): # 이건 매개변수를 꼭 하나 넣어야함
    print('★', error)
    return render_template('error_page.html'), 404

@app.route('/', methods=['GET']) # 대문자, 소문자 상관없지만 주로 대문자로씀
# def index():
#     return render_template('2_crud/index.html')
# 이러면 join에 데코레이터가 두개 쌓이는것. /도 /join도 둘다 join으로 가는것
@app.route('/join', methods=['GET','POST'])
def join():
    print(request.method) # 무슨 방식으로 들어왔는지 표시
    if request.method == 'GET': # 여기서는 반드시 대문자로
        return render_template('2_crud/join.html')
    elif request.method == 'POST':
        # print(request.form) # POST방식으로 전달된 파라미터 내용
        # name = request.form.get('name')
        # id   = request.form['id']
        # pw   = request.form.get('pw')
        # addr = request.form.get('addr')
        try:
            # member = Member(name=name, id=id, pw=pw, addr=addr)
            member = Member(**request.form.to_dict())
        except Exception as e:
            print(f'유효성 실패 : {e}')
            return render_template('2_crud/join.html', 
                                    msg='유효한 데이터를 입력하지 않았습니다',
                                    form_data = request.form)
        return render_template('2_crud/result.html', member=member)
    
@app.route('/update/<name>/<id>/<pw>/<addr>', methods=['PUT'])
def update(name, id, pw, addr):
    return f'{name}님 정보가 수정되었습니다'

@app.route('/delete/<id>', methods=['DELETE'])
def delete(id):
    return f'id가 {id}인 회원정보가 삭제되었습니다'

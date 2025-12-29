from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index(no=None):
    if request.method == 'POST':
        no = request.form.get('no').strip()
    return render_template('2_quiz.html', no=no)

if __name__ == '__main__':
    app.run(debug=True) # 개발단계여서 debug=True 쓰는거고 배포할때는 하면안됨
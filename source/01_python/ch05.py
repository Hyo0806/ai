#ch05.py(ch05 모듈) 자동완성 핫키 : ctrl+space
#ctrl+shift+p -> select interpreter 이용해서 인터프리터(base) 선택
#실행 : cmd 터미널에서(ctrl+j) python ch05.py

def my_hello(cnt): #cnt번 반복
    print(__name__)
    for i in range(cnt):
        print('Hello, Python', end = '\t')
        print('Hello, World')

if __name__ == '__main__': # if문을 안쓰면 위에 문장들이 다 출력이 되기 때문에 if문을 작성하는것
    my_hello(2)
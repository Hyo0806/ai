import sys
sys.path.append(r'C:\Users\Admin\AI\source\pylib')
from sample_pac.ab import a 

# c 안에서 a를 쓰고싶을때 방법. 위에 세줄을 쓰거나 아니면 아래 한줄씩만 쓰거나.
 # from ..ab import a
# python -m sample_pac.cd.c

def nice():
    print('sample_pac/cd 패키지안의 c모듈안의 nice')
    a.hello()

if __name__ == '__main__':
    nice()
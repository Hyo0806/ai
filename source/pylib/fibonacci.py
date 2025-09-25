# ctrl + Shift + p → select interpreter → base
# ctrl + j : cmd창에서 테스트 : python fibonacci.py
def fibonacci_print(n):
    '''
    매개변수로 들어온 n값 미만의 피보나치 수열을 출력하는 함수
    ex. n=10 : 0 1 1 2 3 5 8
       n=100 : 0 1 1 2 3 5 8 13 21 34 55 89
    '''
    a,b = 0,1 
    while a < n:
        print(a, end=' ')
        a, b = b, a+b
    print() 
    
def fibonacci(n):
    'n미만의 피보나치 수열을 리스트로 return'
    result = [] # 피보나치 수열을 append할 리스트
    a,b = 0,1
    while a < n:
        result.append(a) # 리스트에 append
        a,b = b,a+b
    return result

# 피보나치 수열 관련 함수들 테스트(cmd창에서 python fibonacci.py 100) (실행하는데 100넣어 라는말)
if __name__=='__main__':
    import sys
    if len(sys.argv) > 1:
        n = int(sys.argv[1])
    else:
        n = int(input('n?'))
    print('1. print test :', end=' ')
    fibonacci_print(n)
    print('2. return test :', fibonacci(n))
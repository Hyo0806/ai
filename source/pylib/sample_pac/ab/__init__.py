'''
sample_pac/ab/__init__.py
ab 패키지를 impoort할 때 자동 실행
from sample_pac.ab import *을 수행시 a모듈만 자동 import되도록 하기위해  (*은 모든것을 뜻함)
__all__를 셋팅
'''
__all__ = ['a'] #진짜 중요함. 여러개 로드하고 싶으면 ['a','b'] 이런식으로 하면됨
print('sample_pac.ab 패키지 로드')
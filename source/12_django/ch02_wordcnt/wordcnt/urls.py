# wordcnt패키지 안의 urls 모듈
# wordcnt/       : name=wordcnt:wordinput
# wordcnt/about/ : name=wordcnt:abount
# wordcnt/result/: name=wordcnt:result

from django.urls import path
from wordcnt.views import wordinput
app_name = 'wordcnt' # name=wordcnt:wordinput을 name='wordinput'만 칠 수 있음

# 여기까지 왔다는건 이미 wordcnt/하고 온거라서 앞에 wordcnt 안치기
urlpatterns = [
    path('', wordinput, name='wordinput'),   # /wordcnt/ 단어입력 받는 페이지
    # path('about/', about, name='about'),   # /wordcnt/about/ 도움말
    # path('result/', result, name='result') # /wordcnt/result/ 단어입력결과
]
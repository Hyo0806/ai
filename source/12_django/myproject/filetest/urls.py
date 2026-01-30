from django.urls import path
from . import views # GenericView로 DB연동할게 아니라서 함수기반으로 해야하기때문에 views를 가져와야함

# file/         DB에 저장없이 파일첨부 받기(name=file:upload_file)
# file/predict/ 예측결과 출력하기          (name=file:predict)

app_name = 'file'
urlpatterns = [
    path('', views.upload_file, name='upload_file'),
    path('predict/', views.predict, name='predict'),
]
# student 앱 아래의 urls.py
# student/            - name='student:list'
# student/get/<id>    - name='student:get'
# student/delete/<id> - name='student:delete'

from django.urls import path, register_converter
from . import views # student 폴더 말함. .은 현재 폴더
from .converters import MyConverter

register_converter(MyConverter, 'ddd') # 나의 컨버터 이름
app_name = 'student'
urlpatterns = [
    path('', views.list, name='list'),
    path('get/<ddd:id>', views.get, name='get'), # 이제부터 id는 ddd타입으로 들어옴. ddd타입은 myconverters
    path('delete/<ddd:id>', views.delete, name='delete'),
]
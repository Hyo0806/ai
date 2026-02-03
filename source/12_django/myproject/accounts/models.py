from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    # 숫자가 들어온다고 해서 intergerfield로 하면 안되는게 0109999 이렇게 하면 앞의 0이 사라짐
    phone_number = models.CharField(verbose_name='전화', max_length=20) 
    address      = models.CharField(verbose_name='주소', max_length=100)

    def __str__(self):
        return '{}({}-{})'.format(self.user.username, self.phone_number, self.address)
    
# 이벤트 처리 : Profile insert시 가입인사 메일을 전송 → signals(post_save)
from django.db.models.signals import post_save
from django.core.mail import send_mail
from myproject.settings import EMAIL_HOST_USER

def on_send_mail(sender, **kwargs):
    # print('model class :', sender)
    # print(kwargs)
    if kwargs['created']: # true일때만 이메일 전송
        user = kwargs['instance'].user # 저장된 프로파일
        if not user.email:
            print('메일 주소가 없어서 메일을 못 보냅니다')
            return
        subject = user.username + '님 회원가입 환영합니다'
        body = user.username + '님 가입 감사합니다'
        bodyHtml = '''<h1>{}님 가입 감사합니다</h1>
        <h2 style='color:red'>진심진심</h2>
        <img src='https://item.kakaocdn.net/do/3594bf6184340bfb0f90cf007663c1c39f5287469802eca457586a25a096fd31'>
        '''.format(user.username)
        # settings.py에 smtp 셋팅
        send_mail(
            subject = subject,
            message=body,
            from_email=EMAIL_HOST_USER,
            recipient_list=[user.email], # 여기까지는 필수 파라미터
            fail_silently=False, # 메일 전송이 안되었을때, 아무일도 하지 않음
            html_message=bodyHtml
            )
        print('회원가입 후 메일 전송 완료')
        

post_save.connect(on_send_mail, sender=Profile) # Profile인스턴스 DB save 후 on_send_mail 실행
from django.db import models
import re
from django.forms import ValidationError
from django.utils import timezone

# Create your models here.
REGION_CHOICE = ( # pdf 19p 참조. ('db에 입력될 값', 'form태그에 출력될 값')
    ('Europe', '유럽'),
    ('Asia', '아시아'),
    ('Oceania', '오세아니아'),
    ('America', '아메리카'),
    ('Africa', '아프리카'),
)

def lnglat_validator(value):
    if not re.match(r'(\d+\.?\d*),(\d+\.?\d*)', value):
        raise ValidationError('경도 위도 타입이 아닙니다. ex.125,38.5')

class Tag(models.Model):
    name = models.CharField(max_length=50, unique=True)
    def __str__(self):
        return self.name

class Post(models.Model): # 테이블명 : blog_post
    # id = models.AutoField(primary_key=True) PK가 없을 경우 자동 생성
    title = models.CharField(verbose_name='제목', # form의 라벨
                            max_length=100,       # 최대 문자 길이 반드시 지정 VARCHAR(100)
                            help_text='기사 제목입니다. 100자 내외로 입력하세요')
    content = models.TextField(verbose_name='본문') # 최대 문자 길이 제한없음 CLOB타입, TEXT타입
    create_at = models.DateField(auto_now_add=True) # 등록일 자동 저장
    update_at = models.DateTimeField(auto_now=True) # 등록/수정 날짜와 시간 자동 저장
    region = models.CharField(verbose_name='지역', 
                            max_length=100, 
                            choices=REGION_CHOICE, 
                            default='Asia')
    lnglat = models.CharField(verbose_name='경·위도', 
                            max_length=100, 
                            blank=True, 
                            null=True, 
                            help_text='경도, 위도 포맷 ex.37, 125.5',
                            validators=[lnglat_validator]) # 이건 함수만 쓰면 안되고 반드시 리스트로 넣어야함
    url = models.URLField(blank=True, null=True)
    tags = models.ManyToManyField(Tag, blank=True)

    def __str__(self): # 테이블의 한 레코드가 작업대상
        updated = timezone.localtime(self.update_at).strftime('%Y-%m-%d %H:%M')
        return '{}. 제목:{} - {}작성. {}최종수정'.format(self.id ,self.title, self.create_at, updated)
    
    class Meta: # 테이블의 모든 레코드가 작업대상
        # db_table = 'blog_post' 테이블 이름 수정할때는 이렇게함. 근데 아무도 테이블 이름 변경안함
        ordering = ['-update_at'] # 업데이트가 큰것부터 작은것 순서대로 (최신순)
        unique_together = [('title', 'content')] # 같은 title과 content는 insert 불가. 타이틀만 같거나 컨텐츠만 같은것은 가능

class Comment(models.Model): # 테이블명 : blog_comment (Post의 댓글 내용) → post:comment = 1:N
    # id = models.AutoField(primary_key=True)
    post = models.ForeignKey(Post, on_delete=models.CASCADE) # post내용을 delete할 경우 댓글도 자동 삭제
    author = models.CharField(verbose_name='댓글작성자', max_length=20, null=True, blank=True)
    message = models.TextField(verbose_name='댓글')
    create_at = models.DateField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)
    def __str__(self):
        updated = timezone.localtime(self.update_at).strftime('%Y-%m-%d %p %I:%M') # PM 1:30
        updated = updated.replace('AM','오전').replace('PM','오후')
        return '{}글의 댓글 {} (by {}, at {})'.format(self.post.pk, self.message, self.author, updated)
    
    class Meta:
        ordering = ['-update_at']
        unique_together = [('post','author','message')]
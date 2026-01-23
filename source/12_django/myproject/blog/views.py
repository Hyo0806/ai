from django.shortcuts import render, redirect
from django.contrib import messages
from .models import Post

# Create your views here.
# def index(request):
#     return redirect('blog:list')

def list(request):
    print('request:user', request.user) # 로그인 전 : AnonymousUser객체 / 로그인 후 : 로그인한 User객체
    post_list = Post.objects.all()
    return render(request, 'blog/index.html', {'post_list':post_list})

def detail(request, post_id):
    try:
        post = Post.objects.get(pk=post_id)
        return render(request, 'blog/detail.html', {'post':post})
    except:
        messages.error(request, f'{post_id}번 글이 없습니다')
        return redirect('blog:list') # == blog/
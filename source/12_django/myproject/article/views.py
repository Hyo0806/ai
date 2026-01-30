from django.shortcuts import render
from django.views.generic import ListView, CreateView, DetailView, UpdateView, DeleteView
from .models import Article
from django.core.paginator import Paginator
from django.urls import reverse_lazy

# Create your views here.
# /article : 1페이지   /article?page=3

# def article_list(request):
#     article_list = Article.objects.all()
#     q = request.GET.get('q', '') # 없으면 빈스트링으로 받아라.
#     if q:
#         article_list = article_list.filter(title__icontains = q) # q(검색한 단어)가 포함된 단어를 모두 찾아라. contains : 포함된 단어 모두 찾기 / icontains : 대소문자 가리지않고 모두 찾아라
#     paginator = Paginator(article_list, per_page=3)
#     page_number = request.GET.get('page', '1')
#     page_object = paginator.get_page(page_number)
#     return render(request, 'article/article_list.html', {'article_list':page_object, 'page_obj':page_object, 'q':q})

# 위에 함수랑 아래랑 똑같음
class ArticleListView(ListView):
    model = Article
    paginate_by = 3 # 한 페이지당 3개씩 출력
    
    def get_queryset(self): # ListView에 원래 있는 함수. 재정의하는것
        article_list = super().get_queryset() # = article_list = Article.objects.all()
        q = self.request.GET.get('q','')
        if q:
            article_list = article_list.filter(title__icontains=q)
        return article_list
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['q'] = self.request.GET.get('q','')
        return context  

class ArticleCreateView(CreateView):
    model = Article
    fields = '__all__'

from django.utils import timezone
class ArticleDetailView(DetailView):
    model = Article

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['now'] = timezone.now()
        return context
    
class ArticleUpdateView(UpdateView):
    model = Article
    fields='__all__'

class ArticleDeleteView(DeleteView):
    model = Article
    success_url = reverse_lazy('article:list')
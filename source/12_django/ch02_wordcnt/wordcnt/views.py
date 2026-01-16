from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.
def wordinput(request):
    return render(request, 'wordcnt/wordinput.html')

def about(request):
    return render(request, 'wordcnt/about.html')

def result(request):
    # print(request.GET)
    # fulltxt = request.GET['fulltxt']
    # fulltxt = request.GET.get('fulltxt', '') # 홍길동 홍길동 아자
    fulltxt = request.POST.get('fulltxt','')
    strlength = len(fulltxt) # 글자수(10)
    words = fulltxt.split() # space 단위로 단어 분리 ['홍길동', '홍길동', '아자']
    words_dict = dict() # 빈딕셔너리 → {'홍길동':2, '아자':1}
    for word in words:
        if word in words_dict.keys():
            words_dict[word] += 1 # {'홍길동' : 2}
        else:
            words_dict[word] = 1 # {'홍길동':1, '아자':1}
        # {'홍길동':2, '아자':1}
    context = {
        'fulltxt'  : fulltxt,
        'strlength': strlength,   # 글자수
        'wordcnt'  : len(words),  # 단어 갯수
        'dict'     : words_dict.items() # [('홍길동',2), ('아자',1)]
    }
    # print(words_dict.items())
    return render(request=request,
                template_name='wordcnt/result.html', 
                context=context)
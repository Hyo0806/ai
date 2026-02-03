from django.shortcuts import render
# 회원가입
# from django.contrib.auth.forms import UserCreationForm 
from .forms import SignupForm
from django.conf import global_settings as settings
from django.shortcuts import redirect
# 로그인
from django.contrib.auth.views import LoginView, LogoutView
from django.contrib.auth.forms import AuthenticationForm # username과 pw만 받는애
from django.contrib.auth import authenticate, login
# 회원정보 보기
from django.contrib.auth.decorators import login_required
from .models import Profile

# Create your views here.
def signup(request):
    if request.method == 'POST':
        form = SignupForm(request.POST)
        # print(form.is_valid())
        if form.is_valid():
            profile = form.save() # DB 저장
            # 회원가입 후 로그인 페이지로 가기
            request.session['username'] = profile.user.username # 회원가입 후 로그인할 때 자동으로 아이디 추가하기 위함
            return redirect(settings.LOGIN_URL) # 회원가입 성공 후 로그인 페이지로
            # return redirect('/accounts/login')
            # return redirect('login')
    else:
        # form = UserCreationForm()
        form = SignupForm()
    return render(request, 'accounts/signup_form.html', {'form':form})

# login = LoginView.as_view(template_name='accounts/login_form.html') # 로그인
def custom_login(request):
    # 회원가입했을때는 username이 바로 있지만 로그인을 바로 할경우에는 username이 바로 안오기때문에 get으로 써야함
    initial_username = request.session.get('username') 
    if request.method == 'POST':
        # 로그인 처리
        form = AuthenticationForm(request=request, data=request.POST)
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None: # DB에 있다
            login(request, user) # Django에서 user를 세션에 저장하는(로그인시키는) 함수
            # request.session['username'] = username # 세션에 username 저장(비밀번호 달라서 다시 돌아올 때 남아있게)
            next_url = request.GET.get('next', 'profile') # next가 안들어오면 profile로가라
            return redirect(next_url)
        # else: # 이미 기본 오류메세지가 있어서 빼도됨
        #     form.add_error(None, '떼끼') # 로그인 실패시 오류 메세지 추가
    else: # GET방식
        form = AuthenticationForm(
            request=request, 
            initial={'username':initial_username}) # 회원가입후 바로 로그인한 경우 username
    return render(request, 'accounts/login_form.html', {'form':form})

logout = LogoutView.as_view(next_page=settings.LOGIN_URL) # 로그아웃(로그아웃 후에는 로그인 페이지로)

@login_required 
# 로그인 해야지만 들어갈 수있게 하는것
def profile(request):
    profile, created = Profile.objects.get_or_create(
        user = request.user
    )
    print('profile:', profile, '\t created:', created)
    return render(request, 'accounts/profile.html', {'profile':profile, 
                                                    # 'user':request.user,
                                                    'is_new_profile':created})
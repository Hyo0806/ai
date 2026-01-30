from django.shortcuts import render
from django.contrib import messages # sucess, warning, error, info 를 넣을 수 있는 메세지
from myproject import settings # media 루트 가져오기위해서
import os

# Create your views here.
def upload_file(request):
    if request.method == 'POST':
        # 파일첨부 처리
        upload_file = request.FILES.get('file')
        MAX_FILE_SIZE = 10 * 1024 * 1024 # 최대 업로드 사이즈 : 10메가
        
        if upload_file and upload_file.size < MAX_FILE_SIZE:
            # 10메가 미만 파일 첨부함
            upload_dir = os.path.join(settings.MEDIA_ROOT, 'filetest')
            os.makedirs(upload_dir, exist_ok=True) # 폴더가 없을 경우 폴더 생성. 있으면 오케이, 스킵
            file_path = os.path.join(upload_dir, upload_file.name)
            print(file_path, '에 저장함')
            
            with open(file_path, 'wb') as f:
                for chunk in upload_file.chunks(): # 큰 파일 업로드시 조금씩 나눠서 저장
                    f.write(chunk)
            return render(request, 'filetest/result.html')
        
        elif upload_file and upload_file.size >= MAX_FILE_SIZE:
            # 10메가 이상 파일 첨부함
            messages.error(request, f'파일사이즈({int(upload_file.size/(1024))}KB)가 10M를 초과할 수 없습니다')
            messages.warning(request, '10M를 초과할 수 없습니다')
        
        else:
            # 파일 첨부 안함
            messages.success(request, '파일 첨부를 하지 않았습니다')
            messages.info(request, '파일 첨부를 하지 않았습니다')

    return render(request, 'filetest/fileupload.html')

import time

def predict(request):
    time.sleep(3) # predict시간이라 칩시다
    return render(request, 'filetest/predict.html', {'answer':'결과 문구입니다'})
# ctrl+shift+p → python:select interpreter 선택 → llm 가상환경 선택
# 실행 : ctrl+j 터미널

from dotenv import load_dotenv
from openai import OpenAI

def askGPT(prompt):
    'GPT에게 요청해서 prompt 내용을 1줄 요약하여 return'    
    load_dotenv()
    client = OpenAI()
    response = client.chat.completions.create(
        model='gpt-4.1-mini',
        messages=[
            {'role':'system', 'content':'당신은 한국어로 된 텍스트를 잘 요약하는 전문 어시스턴트입니다.'},
            {'role':'user', 'content':prompt}])
    return response.choices[0].message.content

if __name__=='__main__':
    message = input('요약할 글을 입력하세요')
    if message:
        prompt = f'''your task is to summarize the text sentences in Korean language.
        Summarize in 1 line. Use the format of a bullet point.
        text : {message}'''
        result = askGPT(prompt)
        print('--- 요약입니다 ---')
        print(result)
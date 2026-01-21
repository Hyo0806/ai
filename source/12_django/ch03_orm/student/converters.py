# 기본 converter 참조

class MyConverter:
    regex = r"\d{1,3}" # 숫자가 1개부터 3개사이

    def to_python(self, value):
        return int(value)

    def to_url(self, value):
        return str(value)
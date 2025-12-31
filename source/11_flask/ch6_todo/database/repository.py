from database.connection import conn
from models import Todo
from typing import List # 타입 체크용

# get_todos의 매개변수는 문자로 order를 전달받아 return dict list를 반환
def get_todos(order:str='asc') -> List[dict]:
    cursor = conn.cursor()
    if order == 'asc':
        sql = "select * from todo order by id"
    else:
        sql = "select * from todo order by id desc" # desc 내림차순
    cursor.execute(sql)
    result = cursor.fetchall()
    keys = [d[0].lower() for d in cursor.description] # ['id', 'content', 'is_done']
    todos = [dict(zip(keys, d)) for d in result]
    cursor.close()
    return todos

def get_next_id() -> int:
    cursor = conn.cursor()
    sql = "select nvl(max(id), 0) + 1 from todo"
    cursor.execute(sql)
    result = cursor.fetchone() # 반환값은 (4,0) 형태의 tuple
    cursor.close()
    return result[0]

def get_todo(id:int) -> dict:
    cursor = conn.cursor()
    sql = "select * from todo where id = :id"
    cursor.execute(sql, {'id': id})
    result = cursor.fetchone() # 반환값은 tuple
    keys = [d[0].lower() for d in cursor.description]
    todo = dict(zip(keys, result))
    cursor.close()
    return todo

def create_todo(todo:Todo) -> int:
    cursor = conn.cursor()
    sql = "INSERT INTO TODO (ID, CONTENT) VALUES (TODO_SQ.NEXTVAL, :content)"
    cursor.execute(sql, {'content': todo.content})
    rows = cursor.rowcount # insert한 행수
    cursor.close()
    return rows # insert 성공시 1 반환

def update_todo(todo:Todo) -> int:
    cursor = conn.cursor()
    sql = "UPDATE TODO SET CONTENT = :content, IS_DONE = :is_done WHERE ID = :id"
    cursor.execute(sql, todo.model_dump())
    conn.commit() 
    rows = cursor.rowcount # update한 행수
    cursor.close()
    if rows:
        return f'{todo.id}번 {todo.content} 수정 성공'
    return f'{todo.id}번 {todo.content} 수정 실패'

def delete_todo(id:int) -> int:
    cursor = conn.cursor()
    sql = "DELETE FROM TODO WHERE ID = :id"
    cursor.execute(sql, {'id': id})
    conn.commit() 
    rows = cursor.rowcount # delete한 행수
    cursor.close()
    if rows:
        return f'{id}번 삭제 성공'
    return f'{id}번 삭제 실패'

if __name__ == "__main__":
    print('전체목록' , get_todos('desc'))
    print('next id', get_next_id())

# 실행방법 python -m database.repository

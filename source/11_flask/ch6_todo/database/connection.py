# pip install python-dotenv
# pip freeze > requirements.txt

import cx_Oracle
import os
from dotenv import load_dotenv
load_dotenv()

dbserver_ip = os.getenv('DBSERVER_IP')
oracle_port = os.getenv('ORACLE_PORT')
oracle_user = os.getenv('ORACLE_USER')
oracle_password = os.getenv('ORACLE_PASSWORD')

# conn = cx_Oracle.connect('scott', 'tiger', '127.0.0.1:1521/xe') 깃에서 에러날 수 있어서 env파일로 가져오는것
conn = cx_Oracle.connect(oracle_user, oracle_password, f"{dbserver_ip}:{oracle_port}/xe")
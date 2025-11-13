-- 주석
-- [II] SELECT문 - 조회

-- 1. SELECT 문장 작성법
SELECT * FROM TAB;       -- 현 계정(scott)이 가지고 있는 테이블 정보 (실행:CTRL+ENTER)
SELECT * FROM DEPT;     -- DEPT 테이블의 모든 열, 모든 행
SELECT * FROM salgrade; -- SALGRADE 테이블의 모든 열, 모든 행
SELECT * FROM EMP;      -- EMP테이블의 모든 열, 모든 행

-- 2. 특정 열만 출력
-- EMP테이블의 구조. 이건 옆에 주석 달면 안됨
DESC EMP;
SELECT EMPNO, ENAME, SAL, JOB FROM EMP; -- EMP 테이블의 SELECT절의 지정된 열만 출력

-- 열이름에 별칭을 두는 경우 EX. 열이름 AS "별칭". EMPNO는 그대로 있고 파이썬에 던져줄때만 아래처럼 수정한게 나오는것
SELECT EMPNO AS "사번", ENAME AS "이름", SAL AS "급여", JOB AS "직책" FROM EMP; -- 여기는 '', "" 구분해서 써야함. ""은 별칭에서만 사용가능

-- 열이름에 별칭을 두는 경우 EX. 열이름 "별칭", 열이름 "별칭". AS 생략가능
SELECT EMPNO "사 번", ENAME "이 름", SAL "급여", JOB "직책" FROM EMP;   

-- 별칭에 SPACE가 없는 경우는 ""생략 가능. 사실 별칭에 SPACE같은 특수문자 잘 안씀
SELECT EMPNO "사 번", ENAME "이 름", SAL 급여, JOB FROM EMP;

-- 3. 특정 행 출력: WHERE절(조건절) 
    -- 비교연산자 : >, >=, <, <=, 같다(=), 다르다(!=, ^=, <>)
    SELECT EMPNO 사번, ENAME 이름, SAL 급여 FROM EMP WHERE SAL=3000;
    SELECT EMPNO NO, ENAME NAME, SAL FROM EMP WHERE SAL!=3000;
--  SELECT EMPNO NO, ENAME NAME, SAL FROM EMP WHERE SAL^=3000;
--  SELECT EMPNO NO, ENAME NAME, SAL FROM EMP WHERE SAL<>3000;

    -- 비교연산자는 숫자, 문자, 날짜형 모두 가능
    -- A < AA < AAA < AAAA < ... < B < BA < ... < C 
    -- ex1) 사원 이름이 'A','B','C'로 시작하는 사원의 모든 열(필드)
    SELECT * FROM EMP WHERE ENAME < 'D';

    -- ex2) 81년도 이전에 입사한 사원의 모든 열(필드)
    SELECT * FROM EMP WHERE hiredate < '81/01/01';

    -- ex3 부서번호(DEPTNO)가 10번인 사원의 모든 필드
    SELECT * FROM EMP WHERE DEPTNO=10;

    -- SQL문은 대소문자 구별 없음. 데이터는 대소문자 구별
    -- ex4) 이름(ENAME)이 SCOTT인 직원의 모든 데이터
    SELECT * FROM EMP WHERE ENAME = 'SCOTT'; -- SCOTT을 scott이라고 치면 안나옴. 이 데이터는 대소문자 구분
    
-- 4. WHERE절(조건절)에 논리연산자 : AND OR NOT
    -- ex1) 급여(SAL)가 2000이상 3000이하인 직원의 모든 필드
    SELECT * FROM EMP WHERE 2000<=SAL AND SAL<=3000; -- 파이썬과 달리 2000<SAL<3000 이렇게 쓰면 안됨
    
    -- ex2) 82년도 입사한 사원의 모든 필드
    SELECT * FROM EMP WHERE '82/01/01'<=hiredate AND hiredate<='82/12/31'; -- 사실 이렇게 쓰는건 위험함
    
    -- 날짜 표기법 셋팅 (현재:RR/MM/DD)
    ALTER SESSION SET NLS_DATE_FORMAT = 'MM-DD-YYYY';
    SELECT * FROM EMP WHERE TO_CHAR(HIREDATE, 'RR-MM-DD')>='82/01/01'
                        AND TO_CHAR(HIREDATE, 'RR-MM-DD')<='82/12/31';
    ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';
    SELECT * FROM EMP;
    
    -- ex3) 부서번호가 10이 아닌 직원의 모든 필드
    SELECT * FROM EMP WHERE DEPTNO != 10;
    SELECT * FROM EMP WHERE DEPTNO = 10;

-- 5. 산술연산자 (SELECT절, WHERE절, ORDER BY절)
SELECT EMPNO, ENAME, SAL "예전월급", SAL*1.1 "현재월급" FROM EMP;
    -- ex1) 연봉이 10,000이상인 직원의 ENAME(이름), SAL(월급), 연봉(SAL*12) - 연봉순으로 출력
    SELECT ENAME 이름, SAL 월급, SAL*12 연봉    -- 세번째로 해석
        FROM EMP                             -- 첫번째로 해석
        WHERE SAL*12 > 10000                 -- 두번째로 해석(별칭사용불가)
        ORDER BY 연봉; -- 소트                -- 네번째로 해석(별칭사용 가능)

    -- 산술연산의 결과는 NULL을 포함하면 결과도 NULL
    -- ex2) 직원의 ENAME(이름), SAL(월급), 상여(COMM), 연봉(SAL*12+COMM) - 연봉순으로 출력
    SELECT ENAME, SAL, COMM, SAL*12+COMM 연봉 FROM EMP;
    -- NVL(NULL일 수도 있는 필드명, 대체값)을 이용 : 필드명과 대체값은 타입이 일치
    SELECT ENAME, SAL, COMM, SAL*12+NVL(COMM,0) 연봉 FROM EMP;
    
    -- ex3) 모든 사원의 ENAME, MGR(상사사번)을 출력 - 단 상사사번이 없으면 CEO라고 출력
    SELECT ENAME, NVL(TO_CHAR(MGR),'CEO')MGR FROM EMP;
    DESC EMP; -- 타입확인
    
-- 6. 연결연산자 (||) : 필드내용이나 문자를 연결
SELECT ENAME || '은(는)' || JOB FROM EMP;

-- 7. 중복제거(DISTINCT)
SELECT DISTINCT JOB FROM EMP;
SELECT DISTINCT DEPTNO FROM EMP;


    --	연습문제 꼭 풀기
    --1. emp 테이블의 구조 출력
    DESC EMP;
    
    --2. emp 테이블의 모든 내용을 출력 
    SELECT * FROM EMP;
    
    --3. 현 scott 계정에서 사용가능한 테이블 출력
    SELECT * FROM TAB;
    
    --4. emp 테이블에서 사번, 이름, 급여, 업무, 입사일 출력
    SELECT EMPNO, ENAME, SAL, JOB, HIREDATE 
        FROM EMP;
    
    --5. emp 테이블에서 급여가 2000미만인 사람의 사번, 이름, 급여 출력
    SELECT EMPNO, ENAME, SAL 
        FROM EMP 
        WHERE SAL<2000;
    
    --6. 입사일이 81/02이후에 입사한 사람의 사번, 이름, 업무, 입사일 출력
    SELECT EMPNO, ENAME, JOB, HIREDATE 
        FROM EMP 
        WHERE TO_CHAR(HIREDATE, 'RR/MM/DD') >= '81/02/01';
        
    SELECT EMPNO, ENAME, JOB, HIREDATE 
        FROM EMP
        WHERE HIREDATE >= TO_DATE('81/02/01','RR/MM/DD');
        
    --7. 업무가 SALESMAN인 사람들 모든 자료 출력
    SELECT * FROM EMP 
        WHERE JOB = 'SALESMAN';
    
    --8. 업무가 CLERK이 아닌 사람들 모든 자료 출력
    SELECT * FROM EMP 
        WHERE JOB != 'CLERK';
    
    --9. 급여가 1500이상이고 3000이하인 사람의 사번, 이름, 급여 출력
    SELECT EMPNO, ENAME, SAL 
        FROM EMP 
        WHERE 1500<=SAL AND SAL<=3000;
    
    --10. 부서코드가 10번이거나 30인 사람의 사번, 이름, 업무, 부서코드 출력
    SELECT EMPNO, ENAME, JOB, DEPTNO 
        FROM EMP 
        WHERE DEPTNO = 10 OR DEPTNO = 30;
    
    --11. 업무가 SALESMAN이거나 급여가 3000이상인 사람의 사번, 이름, 업무, 부서코드 출력
    SELECT EMPNO, ENAME, JOB, DEPTNO 
        FROM EMP 
        WHERE JOB='SALESMAN' OR SAL>=3000;
    
    --12. 급여가 2500이상이고 업무가 MANAGER인 사람의 사번, 이름, 업무, 급여 출력
    SELECT EMPNO, ENAME, JOB, SAL 
        FROM EMP 
        WHERE SAL>=2500 AND JOB='MANAGER';
    
    --13.“ename은 XXX 업무이고 연봉은 XX다” 스타일로 모두 출력(연봉은 SAL*12+COMM)
    SELECT ENAME || '은(는) ' || JOB || '업무이고 연봉은 ' || (SAL*12+NVL(COMM,0)) || '이다' FROM EMP; -- 연결 연산자부터 계산하다보니 괄호를 넣어야함
    
-- 8. SQL 연산자(BETWEEN, IN, LIKE★★, IS NULL)
    --1) BETWEEN A AND B : A부터 B까지(A,B포함. A<=B)
        -- ex1) SAL이 1500이상 3000이하
        SELECT * FROM EMP WHERE SAL >= 1500 AND SAL <= 3000;
        SELECT * FROM EMP WHERE SAL BETWEEN 1500 AND 3000; -- 거꾸로 쓰면 안됨 : 3000 AND 1500
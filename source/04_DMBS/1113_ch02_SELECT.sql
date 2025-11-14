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
    --1) 필드명 BETWEEN A AND B : 필드명이 A부터 B까지(A,B포함. A<=B)
        -- ex1) SAL이 1500이상 3000이하
        SELECT * FROM EMP WHERE SAL >= 1500 AND SAL <= 3000;
        SELECT * FROM EMP WHERE SAL BETWEEN 1500 AND 3000; -- 거꾸로 쓰면 안됨 : 3000 AND 1500 X
        -- ex1-1) SAL이 1500미만 3000초과 (ex1의 반대)
        SELECT * FROM EMP WHERE SAL < 1500 OR SAL > 3000;
        SELECT * FROM EMP WHERE SAL NOT BETWEEN 1500 AND 3000;
        
        -- ex2) 81년도 봄(3월~5월)에 입사한 직원의 모든 필드
        SELECT * FROM EMP WHERE HIREDATE BETWEEN '81/03/01' AND '81/05/31'; -- 위험한짓
        SELECT * FROM EMP 
            WHERE TO_CHAR(HIREDATE, 'RR/MM/DD') BETWEEN '81/03/01' AND '81/05/31'; -- 안전하게 이렇게 해야함
            
    -- 2) 필드명 IN (값1, 값2, ..., 값N)
        -- ex1) 부서코드가 10번이거나 30번이거나 40번인 사람의 모든 정보
        SELECT * FROM EMP WHERE DEPTNO=10 OR DEPTNO=30 OR DEPTNO=40;
        SELECT * FROM EMP WHERE DEPTNO IN (10,30,40);
        -- ex1-1) ex1의 반대(부서번호가 10번도 아니고, 30번도 아니고, 40번도 아닌사람)
        SELECT * FROM EMP WHERE DEPTNO NOT IN (10,30,40);
        
        -- ex2) 직책(JOB)이 'MANAGER'이거나 'ANALYST'인 사원의 모든 정보
        SELECT * FROM EMP WHERE JOB IN ('MANAGER', 'ANALYST');
        
    -- 3) 필드명 LIKE '패턴' : %(0글자 이상), _(한글자)를 포함하는 패턴
        -- ex) 이름이 M으로 시작하는 사원의 모든 정보
        SELECT * FROM EMP WHERE ENAME LIKE 'M%';
        
        -- ex) 이름이 S로 끝나는 사원의 모든 정보
        SELECT * FROM EMP WHERE ENAME LIKE '%S';
        
        -- ex) 이름에 N이 들어가는 사원의 모든 정보
        SELECT * FROM EMP WHERE ENAME LIKE '%N%'; -- %가 0글자이상이다보니 N앞에붙이고 뒤에붙이고
        
        -- ex) 이름에 N이 들어가고 JOB에 S가 들어가는 사원의 모든 정보
        SELECT * FROM EMP 
            WHERE ENAME LIKE '%N%' AND JOB LIKE '%S%';
            
        -- ex) 급여가 5로 끝나는 사원의 모든 정보
        SELECT * FROM EMP WHERE SAL LIKE '%5';
        
        -- ex) 82년도에 입사한 사원의 모든정보
        SELECT * FROM EMP WHERE HIREDATE LIKE '82/%'; -- 위험한 방식
        SELECT * FROM EMP WHERE TO_CHAR(HIREDATE, 'RR/MM/DD') LIKE '82/%'; 
        SELECT * FROM EMP WHERE TO_CHAR(HIREDATE, 'RR') =82; -- LIKE 예제라서 위의 방식으로 썼지만 이게 훨씬 간단함
        
        -- ex) 1월에 입사한 사원의 모든정보
        SELECT * FROM EMP WHERE TO_CHAR(hiredate, 'RR/MM/DD') LIKE '__/01/__';
        SELECT * FROM EMP WHERE TO_CHAR(hiredate, 'MM') ='01';
        
        -- ex) 이름에 %가 들어간 사원
        SELECT * FROM EMP WHERE ENAME LIKE '%%%'; -- 모두 나옴. %가 아니라 패턴으로 인식하는중
            DESC EMP; -- 여기보면 EMPNO는 NOT NULL 타입. 여기 보고 맞춰서 넣어줘야함
            -- 이름에 %가 들어간 데이터 INSERT(데이터 조작언어-)
            INSERT INTO EMP VALUES (9999, '홍%0동', NULL, NULL, NULL, 9000, 900, 40); -- EMPNO 가 중복이 안되게 되어있는 키라서 두번 실행시키면 에러남
            SELECT * FROM EMP;
        SELECT * FROM EMP WHERE ENAME LIKE '%\%%' ESCAPE '\'; -- 이렇게 쓰면 %를 패턴이 아니라 문자로 인식함
        ROLLBACK; -- DML(데이터 조작어 : 추가, 수정, 삭제, 검색)를 취소

    -- 4) 필드명 IS NULL : 필드명이 널인지 검색할 때
        -- ex) COMM(상여)이 없는 사원
        SELECT * FROM EMP WHERE COMM IS NULL OR COMM=0;
        
        -- ex) COMM(상여)이 받는 사원(COMM != 0 AND COMM이 NULL이 아님)
        SELECT * FROM EMP WHERE COMM IS NOT NULL AND COMM!=0;
        -- SELECT * FROM EMP WHERE COMM NOT IS NULL AND COMM!=0; 에러남
        SELECT * FROM EMP WHERE NOT COMM IS NULL AND COMM!=0;

-- 9. 정렬(오름차순, 내림차순) : ORDER BY 절
SELECT * FROM EMP ORDER BY SAL; -- 오름차순
SELECT * FROM EMP ORDER BY SAL DESC; -- 내림차순. 만약 SAL이 같으면 EMPNO순으로 얘가 자동정렬함

    -- ex) 급여 많은순, 급여가 같을 시 입사일이 최신순(급여 내림차순, 입사일 내림차순)
    SELECT * FROM EMP ORDER BY SAL DESC, HIREDATE DESC;
    
    -- ex) 급여가 2000초과하는 사원을 출력 - 이름 ABC순 출력(오름차순)
    SELECT * FROM EMP WHERE SAL>2000 ORDER BY ENAME;

-- <총 연습문제>
    --1.	EMP 테이블에서 sal이 3000이상인 사원의 empno, ename, job, sal을 출력
    SELECT EMPNO, ENAME, JOB, SAL
        FROM EMP
        WHERE SAL>=3000;
        
    --2.	EMP 테이블에서 empno가 7788인 사원의 ename과 deptno를 출력
    SELECT ENAME, DEPTNO
        FROM EMP
        WHERE EMPNO=7788;
    
    --3.	연봉(SAL*12+COMM)이 24000이상인 사번, 이름, 급여 출력 (급여순정렬)
    SELECT EMPNO, ENAME, SAL
        FROM EMP
        WHERE SAL*12+NVL(COMM,0) >= 24000
        ORDER BY SAL;
    
    --4.	입사일이 1981년 2월 20과 1981년 5월 1일 사이에 입사한 사원의 사원명, 직책, 입사일을 출력 (단 hiredate 순으로 출력)
    SELECT ENAME, JOB, HIREDATE
        FROM EMP
        WHERE TO_CHAR(HIREDATE, 'RR/MM/DD') BETWEEN '81/02/20' AND '81/05/01';
    
    --5.	deptno가 10,20인 사원의 모든 정보를 출력 (단 ename순으로 정렬)
    SELECT * FROM EMP
        WHERE DEPTNO IN (10,20)
        ORDER BY ENAME;
    
    --6.	sal이 1500이상이고 deptno가 10,30인 사원의 ename과 sal를 출력
        -- (단 출력되는 결과의 타이틀을 employee과 Monthly Salary로 출력)
    SELECT ENAME employee, SAL "Monthly Salary"
        FROM EMP
        WHERE SAL >=1500 AND DEPTNO IN (10,30);
    
    --7.	hiredate가 1982년인 사원의 모든 정보를 출력
    SELECT * FROM EMP
        WHERE TO_CHAR(HIREDATE, 'RR')='82';
    
    --8.	이름의 첫자가 C부터  P로 시작하는 사람의 이름, 급여 이름순 정렬(이름기준)
    SELECT ENAME, SAL
        FROM EMP
        WHERE ENAME BETWEEN  'C' AND 'Q' AND ENAME !='Q' -- C AND P 라고 하면 PA가 안나와서 Q로 해야하고 Q는 제외해야함
        ORDER BY ENAME;
    
    --9.	comm이 sal보다 10%가 많은 모든 사원에 대하여 이름, 급여, 상여금을 출력하는 SELECT 문을 작성
    SELECT ENAME, SAL, COMM
        FROM EMP
        WHERE NVL(COMM,0)> SAL*1.1; -- COMM이 NULL이면 FALSE가 되다보니 NVL을 안해도 됨.
        
    --10.	job이 CLERK이거나 ANALYST이고 sal이 1000,3000,5000이 아닌 모든 사원의 정보를 출력
    SELECT * FROM EMP
        WHERE JOB IN ('CLERK','ANALYST') AND SAL NOT IN (1000,3000,5000); 
    
    --11.	ename에 L이 두 자가 있고 deptno가 30이거나 또는 mgr이 7782인 사원의 모든 정보를 출력하는 SELECT 문을 작성하여라.
    SELECT * FROM EMP
        WHERE ENAME LIKE ('%L%L%') AND DEPTNO='30' OR MGR = '7782';
    
    --12.	입사일이 81년도인 직원의 사번, 사원명, 입사일, 업무, 급여를 출력
    SELECT EMPNO, ENAME, HIREDATE, JOB, SAL
        FROM EMP
        WHERE TO_CHAR(HIREDATE, 'RR')=81;
        
    --13.	입사일이81년이고 업무가 'SALESMAN'이 아닌 직원의 사번, 사원명, 입사일, 업무, 급여를 검색하시오.
    SELECT EMPNO, ENAME, HIREDATE, JOB, SAL
        FROM EMP
        WHERE TO_CHAR(HIREDATE, 'RR')=81 AND JOB !='SALESMAN';
    
    --14.	사번, 사원명, 입사일, 업무, 급여를 급여가 높은 순으로 정렬하고,급여가 같으면 입사일이 빠른 사원으로 정렬하시오.
    SELECT EMPNO, ENAME, HIREDATE, JOB, SAL
        FROM EMP
        ORDER BY SAL DESC, HIREDATE;
    
    --15.	사원명의 세 번째 알파벳이 'N'인 사원의 사번, 사원명을 검색하시오
    SELECT EMPNO, ENAME
        FROM EMP
        WHERE ENAME LIKE('__N%');
    
    --16.	사원명에 'A'가 들어간 사원의 사번, 사원명을 출력
    SELECT EMPNO, ENAME
        FROM EMP 
        WHERE ENAME LIKE('%A%');
    
    --17.	연봉(SAL*12)이 35000 이상인 사번, 사원명, 연봉을 검색 하시오.
    SELECT EMPNO, ENAME, SAL*12 ANNUALSAL 
        FROM EMP 
        WHERE SAL*12>=35000;
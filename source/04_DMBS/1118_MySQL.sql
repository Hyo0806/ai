-- 주석은 --+space
-- DCL(계정생성, 권한부여, 권한박탈, 계정삭제)
-- DDL(제약조건 FK, 시퀀스 없음)
-- DML(AND:&&, OR:||, 연결연산자 대신 CONCAT사용, OUTER JOIN)

-- ※ DCL ※ --
create user user01 identified by 'password';
grant all privileges on *.* to user01; -- 권한부여. 모든 스키마, 모든 데이터베이스에 관해서 권한을 주겠다
drop user user01; -- 계정삭제

-- ※ DDL ※ --
-- 기존 데이터베이스들(스키마)
show databases;

create database devdb; -- 새로운 데이터베이스(스키마) devdb 
use devdb; -- devdb 데이터베이스로 들어감
select database(); -- 현재 들어와있는 데이터베이스
show tables; -- 현재 데이터베이스 내의 테이블
create table emp(
	empno    numeric(4)   primary key, -- == number
    ename    varchar(3)   not null, -- mysql에서는 바이트가 아니라 글자수. 오라클에서는 바이트여서 이렇게 쓰면 한글 한글자만 들어감
	nickname varchar(6)   unique,
    sal      numeric(7,2) check(sal>0),
    comm 	 numeric(7,2) default 0
);

/* MySQL 타입 : 
	numeric(n,d)
		정수 : tinyint(1byte), smallint(2byte), mediumint(3byte)
			  int/ integer(4byte), bigint(8byte)
		실수 : float(n,d)(4byte), double(n,d)(8byte)
	varchar(n)
		문자 : char(n), text, mediumtext(16M), longtext(4GB)
	date
		날짜 : date, datetime, time
*/

desc emp;
insert into emp(empno, ename, nickname, sal)
	values (1111, '홍길동', '동해번쩍쩍쩍', 9000);
select * from emp;
select empno no, ename 이름, nickname 별명, sal, comm from emp;

-- 시퀀스 대체, FK제약조건
-- major (mcode 시퀀스, mname, moffice) / student(sno, sname, mcode:FK)
-- set @@auto_increment_increment=10 증감

create table major(
-- 시퀀스 대체하려면 "반드시" int로 써야함. auto_increment필드(int)
	mcode   int primary key  auto_increment, 
	mname   varchar(10),
    moffice varchar(10)
);

create table student(
	sno   numeric(3)  primary key,
    sname varchar(10),
    mcode int references major(mcode)
);

insert into major(mname, moffice) values ('컴공','901호');
insert into major(mname, moffice) values ('인공지능','a601호');
select * from major;

insert into student values (101, '홍길동', 1);
insert into student values (102, '신길동', 2);
insert into student values (104, '김길동', 3); -- FK제약조건이 안들어감
select * from student;


-- FK(외래키) 제약조건 아래에 기술해야함
drop table if exists major;
drop table if exists student;

create table major(
-- 시퀀스 대체하려면 "반드시" int로 써야함. auto_increment필드(int)
	mcode   int   auto_increment, 
	mname   varchar(10),
    moffice varchar(10), 
	primary key(mcode)
);

create table student(
	sno   numeric(3),
    sname varchar(10),
    mcode int,
    primary key(sno),
    foreign key(mcode) references major(mcode) -- FK 제약조건은 반드시 아래에 기술
);

insert into major(mname, moffice) values ('컴공','901호');
insert into major(mname, moffice) values ('인공지능','a601호');
insert into major(mname, moffice) values ('빅데이터','b501호');
select * from major;

insert into student values (101, '홍길동', 1);
insert into student values (102, '신길동', 3);
insert into student values (103, '김길동', 4); -- 에러. FK 제약조건
select * from student;

-- 학번, 이름, 학과번호, 학과명, 학과사무실(학생이 없는 학과도 출력)
select sno, sname, m.mcode, mname, moffice
	from student s right outer join major m -- 오라클과 달리 데이터가 더 많은쪽에 대하여 outer join이라고 써야함. 왼쪽이 데이터가 많으면 left outer join
    on s.mcode = m.mcode;
    
-- ※ DML ※ --
drop table if exists personal; -- emp테이블과 유사
drop table if exists division; -- dept테이블과 유사

create table division(
	dno      int, 				   -- 부서번호
    dname    varchar(20) not null, -- 부서명
    phone    varchar(20) unique,   -- 부서전화
	position varchar(20), 		   -- 부서위치
    primary key(dno)
);

create table personal(
	pno       int, 					-- 사번
    pname     varchar(20) not null, -- 사원명
    job       varchar(20) not null, -- 직책
    manager   int, 			    	-- 상사의 사번
    startdate date, 				-- 입사일
    pay       int, 					-- 급여
    bonus     int, 					-- 상여
    dno       int,
    primary key(pno),
    foreign key(dno) references division(dno)
);

insert into division values (10, 'finance', '02-2088-5679','신림');
insert into division values (20, 'research', '02-555-4321','강남');
insert into division values (30, 'sales', '02-717-4321','마포');
insert into division values (40, 'cs', '031-4444-4321','수원');

insert into personal values (1111,'smith','manager', 1001, '1990-12-17', 1000, null, 10);
insert into personal values (1112,'ally','salesman',1116,'1991-02-20',1600,500,30);
insert into personal values (1113,'word','salesman',1116,'1992-02-24',1450,300,30);
insert into personal values (1114,'james','manager',1001,'1990-04-12',3975,null,20);
insert into personal values (1001,'bill','president',null,'1989-01-10',7000,null,10);
insert into personal values (1116,'johnson','manager',1001,'1991-05-01',3550,null,30);
insert into personal values (1118,'martin','analyst',1111,'1991-09-09',3450,null,10);
insert into personal values (1121,'kim','clerk',1114,'1990-12-08',4000,null,20);
insert into personal values (1123,'lee','salesman',1116,'1991-09-23',1200,0,30);
insert into personal values (1226,'park','analyst',1111,'1990-01-03',2500,null,10);

-- mySQL은 workbench가 자동커밋. 대신 rollback도 안됨 . 
-- edit - preference - sql execution - new connections use auto commit mode를 해제하면 내가 커밋,롤백할수있음
select * from division;
select * from personal;

-- 1. 사번, 이름, 급여를 출력
select pno, pname, pay from personal;

-- 2. 급여가 2000~5000 사이 모든 직원의 모든 필드
select * from personal
	where pay between 2000 and 5000;

-- 3. 부서번호가 10또는 20인 사원의 사번, 이름, 부서번호
select pno, pname, dno
	from personal
    where dno = 10 or dno= 20;
    -- where dno in (10,20)

-- 4. 보너스가 null인 사원의 사번, 이름, 급여 급여 큰 순정렬
select pno, pname, pay
	from personal
    where bonus is null
    order by pay desc;
    
-- 5. 사번, 이름, 부서번호, 급여. 부서코드 순 정렬 같으면 PAY 큰순
select pno, pname, dno, pay
	from personal
    order by dno, pay desc;
    
-- 6. 사번, 이름, 부서명
select pno, pname, dname
	from personal p, division d
    where p.dno=d.dno;
    
    select pno, pname, dname
	from personal p left join division d -- left join : 왼쪽 데이터 기준
    on p.dno=d.dno;

-- 7. 사번, 이름, 상사이름
select w.pno, w.pname, m.pname manager_name 
	from personal w, personal m
	where w.manager=m.pno; -- 상사가 있는 9명만 출력
    
-- 8. 사번, 이름, 상사이름(상사가 없는 사람도 출력하되 상사가 없는 경우 ★CEO★로 출력 nvl없음) 
select w.pno, w.pname, ifnull(m.pname, 'ceo') manager_name 
	from personal w left outer join personal m
    on w.manager=m.pno;

-- 8-1 사번, 이름, 상사사번(상사가 없으면 ceo로 출력. ifnull함수의 매개변수의 타입이 상이해도 상관없음)
select pno, pname, ifnull(manager, 'ceo') manager 
	from personal; -- ifnull은 타입이 달라도됨

-- 8-2. 사번, 이름, 상사이름, 부서명(상사가 없는 사람도 출력) – 같이 합시다
-- (1)
select w.pno, w.pname, ifnull(m.pname, 'ceo') manager_name, dname
	from division d, personal w left outer join personal m -- division을 앞에 넣어야함.  
    on w.manager=m.pno
    where w.dno=d.dno;

-- (2)    
select w.pno, w.pname, ifnull(m.pname, 'ceo') manager_name, dname
	from (personal w, division d) left outer join personal m   
    on w.manager=m.pno
    where w.dno=d.dno;
    
-- (3)    
select w.pno, w.pname, ifnull(m.pname, 'ceo') manager_name, dname
	from personal w left outer join personal m   
		on w.manager=m.pno, division d -- 사실 들여쓰기가 이런식.
    where w.dno=d.dno;
    
-- (4)    
select w.pno, w.pname, ifnull(m.pname, 'ceo') manager_name, dname
	from personal w left outer join personal m   
		on w.manager=m.pno left join division d -- 왼쪽 기준으로 join 
		on w.dno=d.dno;
        
-- (5)    
select w.pno, w.pname, ifnull(m.pname, 'ceo') manager_name, dname
	from personal w left outer join personal m   
		on w.manager=m.pno join division d -- 매칭되는 거만 보여줌 
		on w.dno=d.dno;

-- 9. 이름이 s로 시작하는 사원 이름 (like 이용)
select pname 
	from personal
    where pname like 's%';
    
-- 10. 사번, 이름, 급여, 부서명, 상사이름
select w.pno, w.pname, w.pay, dname, m.pname manager_name
	from personal w, personal m, division d
    where w.manager=m.pno and w.dno=d.dno;
    
-- oracle과 다른 함수들. 연결연산자(||)
select pname||'은'||job from personal; -- or라서 연결연산이 안됨
select concat(pname, '은', job) from personal; -- oracle은 2개까지밖에 연결 안되는데 여기는 쭉 연결됨

-- to_char(hiredate, '')
select sysdate(); -- mySQL은 select절만도 가능
-- date_format(날짜형, 포맷) : 날짜형을 문자형으로
-- date_format(문자형, 포맷) : 문자형을 날짜형으로
	-- %Y(년도4자리) %y(년도2자리) %m(월) %d(일 01,02,..) %c(일 1,2,...) %h(12시) %H(24시) %i(분) %s(초) %p(오전)
select date_format(sysdate(), '%y년 %m월 %d일 %p %h:%i:%s') 지금; -- ""이건 엘리어스라서 ''써야함
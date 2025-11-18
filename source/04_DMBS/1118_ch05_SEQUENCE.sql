-- [V] SEQUENCE : 순차번호 생성기. 대부분 인위적인 PK 사용 용도

DROP SEQUENCE FRIEND_SQ;
CREATE SEQUENCE FRIEND_SQ
    START WITH 1 -- 1부터 생성(기본값)
    INCREMENT BY 1 -- 1씩 증가(기본값)
    MAXVALUE 9999 -- 최대값(기본은 10000이 되면 1로 돌아감)
    -- MINVALUE -9999 INCREMENT BY -1이라고 하면 내림차순으로 떨어짐
    NOCYCLE -- PRIMARY KEY로 사용할것이라서 1이 중복되면 안되니 설정해줌
    NOCACHE; -- 캐시메모리를 사용 안함. 이걸 설정해주지 않으면 컴퓨터 끌때 미리 만들어진 캐시가 사라지면서 다음에 설정하는 인덱스 숫자가 뛸 때가 있음

SELECT * FROM DUAL; -- DAUL : 오라클이 제공하는 1행 1열짜리 테이블    
SELECT FRIEND_SQ.NEXTVAL FROM DUAL; -- NEXTVAL(순차번호 생성)
SELECT FRIEND_SQ.CURRVAL FROM DUAL; -- CURRVAL(현재까지 진행된 순차번호)

    -- ex) 시퀀스를 이용한 FRIEND 테이블
    DROP TABLE FRIEND;
    CREATE TABLE FRIEND(
        NO          NUMBER(5)    PRIMARY KEY, -- 진짜 데이터가 아니라 인위적인 키 만든것
        NAME        VARCHAR2(30) NOT NULL,
        TEL         VARCHAR2(20) UNIQUE, -- 010 으로 시작할때 0이 사라지는것을 방지하기 위해. 그리고 원래는 전화번호에 UNIQUE 잘 안씀
        ADDRESS     VARCHAR2(300),
        LAST_MODIFY DATE         DEFAULT SYSDATE
    ); 
    
    DROP SEQUENCE FRIEND_SQ;
    CREATE SEQUENCE FRIEND_SQ
        MAXVALUE 99999
        NOCACHE
        NOCYCLE;
        
    INSERT INTO FRIEND (NO,NAME, TEL, address) VALUES (FRIEND_SQ.NEXTVAL, '홍길동', NULL, '신림'); -- 여러번 실행 가능. 번호가 특정되어있지않으니 가능
    SELECT * FROM FRIEND;
    SELECT NO, NAME, TEL, ADDRESS, TO_CHAR(LAST_MODIFY, 'RR/MM/DD AM HH:MI:SS') LAST_MODIFY FROM FRIEND;
    
    INSERT INTO FRIEND VALUES (FRIEND_SQ.NEXTVAL, '김길동', '010-9999-9999', '봉천', SYSDATE);
    
    
    -- 연습문제
    DROP TABLE MEMBER;
    DROP TABLE MEMBER_LEVEL;
    
    CREATE TABLE MEMBER_LEVEL(
        LEVELNO   NUMBER(2)    PRIMARY KEY,
        LEVELNAME VARCHAR2(20) NOT NULL
    );
    
    CREATE TABLE MEMBER(
        mNO     NUMBER(5)    PRIMARY KEY,
        mNAME   VARCHAR2(20) NOT NULL,
        mPW     VARCHAR2(8)  NOT NULL,
        -- mPW     VARCHAR2(8)  CHECK(LENGTH(MPW) BETWEEN 1 AND 8),
        mEMAIL  VARCHAR2(30) UNIQUE,
        mPOINT  NUMBER(10)   CHECK(mPOINT >=0),
        mRDATE  DATE         DEFAULT SYSDATE,
        LEVELNO NUMBER(2)    REFERENCES MEMBER_LEVEL(LEVELNO)
    );
    
    SELECT * FROM MEMBER_LEVEL;
    SELECT * FROM MEMBER;
    
    -- 한꺼번에 실행하고싶으면 블럭잡아서 F9키
    INSERT INTO MEMBER_LEVEL VALUES (-1, 'BLACK');
    INSERT INTO MEMBER_LEVEL VALUES (0, '일반');
    INSERT INTO MEMBER_LEVEL VALUES (1, '실버');
    INSERT INTO MEMBER_LEVEL VALUES (2, '골드');
    
    CREATE SEQUENCE MEMBER_MNO_SQ
        MAXVALUE 9999
        NOCACHE
        NOCYCLE;
        
    INSERT INTO MEMBER VALUES (MEMBER_MNO_SQ.NEXTVAL, '홍길동', 'aa', 'hong@hong.com', 0, '24/09/26', 0);
    INSERT INTO MEMBER VALUES (MEMBER_MNO_SQ.NEXTVAL, '신길동', 'bb', 'sin@sin.com', 1000, '22/04/01', 1);
    
    SELECT MNO, MNAME, TO_CHAR(MRDATE, 'RRRR-MM-DD') mRDATE, MEMAIL, MPOINT, L.LEVELNAME||'고객' LEVELNAME 
        FROM MEMBER M, MEMBER_LEVEL L
        WHERE M.LEVELNO=L.LEVELNO;
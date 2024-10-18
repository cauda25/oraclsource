CREATE TABLE USERTBL(
	userid varchar2(20) PRIMARY KEY,
	name varchar2(20) NOT NULL,
	password varchar2(20) NOT NULL,
	age number(3) NOT NULL,
	email varchar2(20) NOT NULL
);

INSERT INTO USERTBL values('hong123','홍길동','hong123',25,'hong@gmail.com');


ALTER TABLE USERTBL MODIFY email varchar2(50);

-- userid 와 password가 일치하는 회원 조회
SELECT userid,name FROM USERTBL WHERE USERID ='hong123' AND PASSWORD ='hong123';

-- 회원 전체 조회
SELECT USERID,NAME,AGE,EMAIL FROM USERTBL u ;

-- 비밀번호 변경
-- 아이디와 현재 비밀번호가 일치하면 새 비밀번호로 변경
UPDATE USERTBL
SET PASSWORD = 'hong456'
WHERE userid='hong123'AND password='hong123';

DELETE FROM usertbl WHERE userid='hong123'AND password='hong1234';

CREATE TABLE booktbl(
	code number(4) PRIMARY KEY,
	title varchar2(50) NOT null,
	writer varchar2(50) NOT null,
	price number(10) NOT null
);

ALTER TABLE BOOKTBL ADD description varchar2(1000);

INSERT INTO booktbl VALUES (1000,'자바의 정석','신용균',25000);
INSERT INTO booktbl VALUES (1001,'자바의 신','강신용',25000);
INSERT INTO booktbl VALUES (1002,'자바의 1000제','남궁성',25000);
INSERT INTO booktbl VALUES (1003,'채식주의자','한강',13500);
INSERT INTO booktbl VALUES (1004,'당신이 누군가를 죽였다','히가시노 게이노',17820);

-- 전체 조회
SELECT * FROM BOOKTBL b;
-- 도서번호 1000 번인 도서 조회
SELECT * FROM BOOKTBL b WHERE CODE = 1000; 
-- 도서번호 1001 번인 도서 가격 수정
UPDATE BOOKTBL SET PRICE = 15000 WHERE CODE = 1001;
-- 도서번호 1001 번인 도서 가격 및 상세설명 수정
UPDATE BOOKTBL SET PRICE = 15000, description='상세설명' WHERE CODE = 1001;
-- 도서번호 1004 번인 도서 삭제
DELETE FROM BOOKTBL b WHERE code = 1212;
-- 도서명 '자바' 키워드가 들어있는 도서 조회
SELECT * FROM BOOKTBL b WHERE TITLE LIKE '%자바%'; 
ALTER TABLE BOOKTBL MODIFY title varchar2(100);

-- 더미 데이터 삽입
CREATE SEQUENCE BOOK_SEQ
START WITH 2000;

INSERT INTO BOOKTBL(CODE,TITLE,WRITER,PRICE)
(SELECT BOOK_SEQ.nextval,TITLE,WRITER,PRICE FROM BOOKTBL b);

SELECT count(*) FROM BOOKTBL b;

CREATE TABLE mamberTBL(
	userid varchar2(20) PRIMARY KEY,
	name varchar2(20) NOT NULL,
	password varchar2(20) NOT NULL
);
ALTER TABLE mamberTBL RENAME TO MEMBERTBL;

INSERT INTO mamberTBL(userid,name,password) values('hong123','홍길동','hong123');

--아이디와 비밀번호가 일치하는 회원 조회(로그인)
SELECT * FROM MEMBERTBL m WHERE USERID='hong123'AND PASSWORD='hong123';

-- 중복 아이디 검사
SELECT * FROM MEMBERTBL m WHERE USERID='hong123'

-- 비밀번호 변경
UPDATE MEMBERTBL
SET PASSWORD = 'hong456'
WHERE userid='hong123'AND password='hong123';

-- board
-- bno(pk),name(varchar2-20),password(varchar2-20),title(varchar2-100),content(varchar2-2000),file(varchar2-100),re_ref,re_lev,re_seq,readcnt,regdate(date-sysdate)
CREATE TABLE board(
	bno number(10) PRIMARY KEY,
	name varchar2(20) NOT NULL,
	password varchar2(20) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(2000) NOT NULL,
	file_f varchar2(100) NOT NULL,
	re_ref number(10) NOT NULL,
	re_lev number(10) NOT NULL,
	re_seq number(10) NOT NULL,
	readcnt number(10) DEFAULT 0,
	regdate DATE DEFAULT sysdate
);

-- 시퀀스 생성 board_seq
CREATE SEQUENCE board_seq;



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

-- board attach not null==> null 가능
ALTER TABLE BOARD MODIFY file_f varchar2(100) NULL;

INSERT INTO BOARD(bno,name,password,title,content,re_ref,re_lev,re_seq)
values(board_seq.nextval, 'hong','12345','board 작성','board 작성',board_seq.currval,0,0)

select bno,name,title,readcnt,regdate from board;

select bno,name,title,readcnt,regdate from board  order BY bno DESC;

select * from board where bno = 1;

--수정
--bno와 password 가 일치 시 title,content 수정
UPDATE BOARD SET title='변경제목' , content='변경내용' WHERE bno=1 AND password='12345';

-- 조회수 업데이트
UPDATE BOARD 
SET READCNT = READCNT +1
WHERE bno=3;

-- 더미 데이터
INSERT INTO BOARD(bno,name,password,title,content,re_ref,re_lev,re_seq)
(SELECT board_seq.nextval,name,PASSWORD,TITLE,CONTENT,board_seq.currval,RE_LEV,RE_SEQ FROM BOARD b);

SELECT COUNT(*) FROM BOARD b; 

-- 댓글처리

-- 가장 최신글에 댓글 처리
SELECT
	*
FROM
	BOARD b
WHERE
	bno =(
	SELECT
		max(bno)
	FROM
		BOARD b);
 
-- 그룹 개념(re_ref : 부모글의 re_ref 넣어주기)
-- re_lev : 부모글 re_lev + 1
-- re_seq : 부모글 re_seq + 1
INSERT INTO BOARD(bno,name,password,title,content,re_ref,re_lev,re_seq) 
values(board_seq.nextval, 'hong','12345','board 작성','board 작성',611,1,1);

--UPDATE BOARD SET RE_LEV=1, RE_SEQ=1 WHERE bno=612;

-- 원본글과 댓글 함께 조회
SELECT * FROM BOARD b WHERE RE_REF =611;

-- 두번째 댓글추가 (최신순 조회:re_seq)
-- re_seq 낮을수록 최신글

-- 원본글
-- ㄴ 댓글2
--   ㄴ 댓글22
-- ㄴ 댓글1

-- 댓글2 추가
-- 먼저 들어간 댓글이 있다면 re_seq + 1해야 함
-- UPDATE BOARD SET RE_SEQ = RE_SEQ +1 WHERE RE_REF =부모글 AND RE_SEQ >부모글 re_seq;
UPDATE BOARD SET RE_SEQ = RE_SEQ +1 WHERE RE_REF =611 AND RE_SEQ >0;

INSERT INTO BOARD(bno,name,password,title,content,re_ref,re_lev,re_seq) 
values(board_seq.nextval, 'hong','12345','댓글 board 작성','댓글 board 작성',611,1,1);

SELECT * FROM BOARD b WHERE RE_REF =611 ORDER BY RE_REF DESC, RE_SEQ ASC;

-- 검색
-- 조건 title or content or name
-- 검색어
select bno,name,title,readcnt,regdate,re_lev from board WHERE TITLE LIKE '%안녕%' order by RE_REF DESC, RE_SEQ ASC;
select bno,name,title,readcnt,regdate,re_lev from board WHERE CONTENT LIKE '%작성%' order by RE_REF DESC, RE_SEQ ASC;
select bno,name,title,readcnt,regdate,re_lev from board WHERE NAME LIKE '%홍%' order by RE_REF DESC, RE_SEQ ASC;

-- 오라클 페이지 나누기
-- 정렬이 완료된 후 번호를 매겨서 일부분 추출
SELECT rownum, bno,name,title,readcnt,regdate,re_lev from board order by RE_REF DESC, RE_SEQ ASC;

SELECT rownum, bno,name,title,readcnt,regdate,re_lev from board order by BNO DESC;

SELECT rnum,bno,name,title,readcnt,regdate,re_lev
FROM (SELECT rownum rnum,bno,name,title,readcnt,regdate,re_lev
FROM (SELECT bno,name,title,readcnt,regdate,re_lev from board order by RE_REF DESC, RE_SEQ ASC)
WHERE rownum <= 20)
WHERE rnum > 10;

-- 1 page요청 : rownum <= 10 rnum >0
-- 2 page요청 : rownum <= 20 rnum >10

-- rownum : 1page * 10 = 10
-- rnum : (1page -1 ) * 10;

-- 전체 개수
SELECT count(*) FROM BOARD;

-- 검색어 기준으로 전체개수
SELECT count(*) FROM BOARD WHERE TITLE LIKE '%안녕%';
SELECT count(*) FROM BOARD WHERE CONTENT LIKE '%안녕%';
SELECT count(*) FROM BOARD WHERE NAME LIKE '%안녕%';

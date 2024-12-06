CREATE TABLE memo(
	mno number(20) PRIMARY KEY,
	memo_text varchar2(200) NOT null
);

CREATE SEQUENCE meno_seq;

SELECT * FROM memo;

DROP TABLE memo;
DROP SEQUENCE meno_seq;

INSERT  INTO MEMO m values(memo_seq.nextval,'오늘의 할 일');

-- 회원 ,팀
-- 회원은 단 하나의 팀에 소속된다
-- 하나의 팀에는 여러 회원 소속된다

-- 회원(아이디,이름,팀 정보)
-- 팀(아이디, 팀명)

CREATE TABLE team(
	team_id varchar2(100) PRIMARY KEY,
	name varchar2(100) NOT NULL	
);


CREATE TABLE team_member(
	member_id varchar2(100) PRIMARY KEY,
	username varchar2(100) NOT NULL,
	team_id varchar2(100) CONSTRAINT fk_member_team REFERENCES team(team_id)
);

INSERT INTO team values('teml','팀1');
INSERT INTO team values('tem2','팀2');

INSERT INTO team_member values('user1','홍길동','tem2');

-- 홍길동이 소속된 팀의 이름 조회
-- 내부 조인
SELECT tm.USERNAME, tm.MEMBER_ID, t.TEAM_ID, t.NAME 
FROM TEAM_MEMBER tm JOIN TEAM t ON tm.TEAM_ID =t.TEAM_ID ;

-- Hibernate 외부조인 (@ManyToOne)
    SELECT
	m1_0.id,
	t1_0.id,
	t1_0.name,
	m1_0.user_name
FROM
	team_member m1_0
LEFT JOIN
        team t1_0 
            ON
	t1_0.id = m1_0.team_id
WHERE
	m1_0.id = 'user1';

--회원조회시 같은 팀에 소속된 회원 조회
--팀1

SELECT * FROM TEAM_MEMBER tm;

SELECT tm.USER_NAME, tm.ID, t.ID, t.NAME 
FROM TEAM_MEMBER tm JOIN TEAM t ON tm.TEAM_ID = t.ID WHERE t.name ='팀1';

UPDATE TEAM_MEMBER 
SET TEAM_ID ='team2'
WHERE TEAM_ID ='team1'AND id = 'user6';

-- parent 삭제
DELETE FROM PARENT p 
WHERE p.id = 3;

-- BOARD ID 기준으로 내림차순 
SELECT  * FROM  BOARD b ORDER BY B.ID DESC;

SELECT  * FROM  BOARD b WHERE b.ID >0 ORDER BY B.ID DESC;

-- 실행계획
-- 1) FULL
-- 2) INDEX(RANGE SCAN)

-- JpqlMember 와 Team 내부 조인 : 팀명이 team2 인 멤버 조회
SELECT
	*
FROM
	JPQL_MEMBER jm
JOIN JPQL_TEAM jt ON
	jm.TEAM_ID = jt.ID
	AND jt.NAME = 'tema 2';

SELECT * FROM JPQL_MEMBER jm JOIN JPQL_TEAM jt ON jm.TEAM_ID = jt.ID WHERE jt.NAME = 'tema 2';

SELECT * FROM MART_ITEM mi WHERE mi.NAME ='POWER' AND mi.PRICE > 10000;

-- mart_orders, mart_member, mart_order_item 조인

SELECT
	*
FROM
	MART_ORDERS mo
JOIN MART_MEMBER mm ON
	mo.MEMBER_MEMBER_ID = mm.MEMBER_ID
JOIN MART_ORDER_ITEM moi ON
	mo.ORDER_ID = moi.ORDER_ORDER_ID;


SELECT
	*
FROM
	MART_ORDERS mo
JOIN MART_MEMBER mm ON
	mo.MEMBER_MEMBER_ID = mm.MEMBER_ID
LEFT JOIN MART_ORDER_ITEM moi ON
	mo.ORDER_ID = moi.ORDER_ORDER_ID;

-- 주문번호에 따른 주문 상품의 개수 추출
SELECT
	moi.ORDER_ORDER_ID,
	COUNT(moi.ORDER_ITEM_ID) AS cnt,
	sum(moi.COUNT) AS sum
FROM
	MART_ORDER_ITEM moi
GROUP BY
	moi.ORDER_ORDER_ID;

-- 서브 쿼리
-- 1) from 에 서브쿼리 사용(인라인뷰)
-- 2) where 에 서브쿼리 사용(중첩 서브쿼리)
-- 3) select 에 서브쿼리 사용(스칼라)

-- 주문내역 + 주문 아이템
SELECT
	mo.ORDER_ID ,mo.STATUS ,a.cnt, a.sum
FROM
	MART_ORDERS mo
LEFT JOIN (
	SELECT
		moi.ORDER_ORDER_ID AS ooi,
		COUNT(moi.ORDER_ITEM_ID) AS cnt,
		sum(moi.COUNT) AS sum
	FROM
		MART_ORDER_ITEM moi
	GROUP BY
		moi.ORDER_ORDER_ID) a ON
	mo.ORDER_ID = a.ooi;


SELECT
	mo.ORDER_ID ,
	mo.STATUS ,
	(
	SELECT
		COUNT(moi.ORDER_ORDER_ID)
	FROM
		MART_ORDER_ITEM moi
	WHERE
		mo.ORDER_ID = moi.ORDER_ORDER_ID
	GROUP BY
		moi.ORDER_ORDER_ID) AS cnt
FROM
	MART_ORDERS mo

--
SELECT * FROM BOARD_ID bi;

-- 100번 게시물에 달린 댓글 가져오기
-- board 정보 ,reply 추출
SELECT
	*
FROM
	BOARD_ID bi
JOIN BOARD_REPLY br ON
	bi.BNO = br.BOARD_BNO
WHERE
	bi.bno = 44;

SELECT
	bi.BNO ,
	bi.TITLE,
	(
	SELECT
		COUNT(br.RNO)
	FROM
		BOARD_REPLY br
	WHERE
		br.BOARD_BNO = bi.BNO 
		) AS cnt,
	bi.WRITER_EMAIL ,
	bi.REGDATE
FROM
	BOARD_ID bi;

-- 게시물 + 게시물에 달려있는 댓글 개수 + 게시물 작성자 이름
SELECT
	bi.BNO ,
	bi.TITLE,
	(
	SELECT
		COUNT(br.RNO)
	FROM
		BOARD_REPLY br
	WHERE
		br.BOARD_BNO = bi.BNO 
		) AS cnt,
	bi.WRITER_EMAIL ,
	bi.REGDATE,
	bm.NAME 
FROM
	BOARD_ID bi
JOIN BOARD_MEMBER bm ON
bi.WRITER_EMAIL = bm.EMAIL ;


SELECT
	br.BOARD_BNO,COUNT(br.RNO)
FROM
		BOARD_REPLY br
GROUP BY
	br.BOARD_BNO;

DELETE FROM BOARD_ID bi WHERE bi.bno = 3;

-- 자식 (reply)삭제 ,부모 (board) 삭제
DELETE FROM BOARD_REPLY br WHERE br.BOARD_BNO = 3;
DELETE FROM BOARD_ID bi WHERE bi.bno = 3;

-- booktbl + publihser + category
-- 카테고리 ,제목 ,저자 ,출판사명

SELECT
	bc.CATEGORY_NAME ,b.TITLE,b.WRITER,bp.PUBLISHER_NAME 
FROM
	BOOKTBL b
JOIN BOOK_PUBLISHER bp ON
	b.PUBLISHER_PUBLISHER_ID = bp.PUBLISHER_ID 
JOIN BOOK_CATEGORY bc ON
	b.CATEGORY_CATEGORY_ID = bc.CATEGORY_ID ;

-- 페이지 나누기 + 검색
SELECT *
FROM(SELECT rownum rn, b.*
FROM (SELECT * FROM BOOKTBL b ORDER BY BOOK_ID DESC ) b
WHERE (title LIKE '%title%' OR writer LIKE '%나라%')
AND rownum <= 20)
WHERE rn >10;


SELECT t.book_id,t.title,t.writer,t.publisher_id
from(SELECT
	rownum rn,
	b1.*
FROM
	(
	SELECT
		*
	FROM
		BOOKTBL b
	JOIN BOOK_PUBLISHER bp ON
		b.PUBLISHER_PUBLISHER_ID = bp.PUBLISHER_ID
	JOIN BOOK_CATEGORY bc ON
		b.CATEGORY_CATEGORY_ID = bc.CATEGORY_ID
	WHERE
		b.BOOK_ID > 0
	ORDER BY
		b.BOOK_ID DESC) b1
WHERE
	(category_name LIKE '%소설%')and
	rownum <= 10) t
WHERE  rn > 0;



SELECT LAST_number FROM user_sequences WHERE sequence_name ='GUESTBOOK_ID_SEQ';
ALTER SEQUENCE GUESTBOOK_ID_SEQ INCREMENT BY -309;
SELECT GUESTBOOK_ID_SEQ.nextval FROM dual;
SELECT GUESTBOOK_ID_SEQ.currval FROM dual;
ALTER SEQUENCE GUESTBOOK_ID_SEQ INCREMENT BY 1;

create table test(num number);
insert into test(num) values(1);

INSERT into GUESTBOOK_ID values(GUESTBOOK_ID_SEQ.nextval,''','','안녕하세요','제목','저자');

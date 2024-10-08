CREATE TABLE BOARD(
	BNO NUMBER(10) PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL,
	PASSWORD VARCHAR2(20) NOT NULL,
	TITLE VARCHAR2(20) NOT NULL,
	CONTENT VARCHAR2(50) NOT NULL,
    READCNT NUMBER(10) default 0,
    REGDATE DATE DEFAULT sysdate
);

-- 시퀀스 생성 : 1씩 증가 board_seq
CREATE SEQUENCE board_seq;
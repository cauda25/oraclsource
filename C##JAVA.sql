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
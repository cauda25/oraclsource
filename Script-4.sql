CREATE TABLE usertbl(
userid varchar2(20) PRIMARY KEY,
name varchar2(20) NOT NULL,
password varchar2(20) NOT NULL,
age number(3) NOT NULL,
email varchar2(20) NOT NULL,
);

INSERT INTO usertbl values('hong123','홍길동','hong123',25,'hong123@gmail.com');

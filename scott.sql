-- SQL 퀴리문은 대소문자를 구별하지 않음 단, 비밀번호는 구별
-- DML : 데이터 조작어(CRUD - Create/ Read / Update / Delete)

-- 1) 조회
-- SELECT 컬럼명 ---------- 5)
-- FROM 테이블명 ----------- 1)
-- WHERE 조건절 ----------- 2)
-- GROUP BY 컬럼명 -------- 3)
-- HAVING 집계함수 조건절 ---- 4)
-- ORDER BY 컬럼명... ----- 6)

-- EMP(employee - 사원 테이블)
-- DEPT(department - 부서 테이블)
-- SALGRADE(급여 테이블)

-- 전체 조회
SELECT * FROM EMP e; -- e 별칭

-- 선택 조회
-- 1) 컬럼 지정
SELECT
	EMPNO,
	ENAME,
	MGR
FROM
	EMP e;
	
-- 중복 조회 : DISTINCT
SELECT DISTINCT DEPTNO
FROM EMP e; 

-- 별칭
SELECT EMPNO AS "사원번호"
FROM EMP e;

SELECT EMPNO "사원번호"
FROM EMP e;

SELECT EMPNO AS "사원 번호"
FROM EMP e;

--
SELECT EMPNO, ENAME, SAL, COMM, SAL*12+COMM AS "연봉"
FROM EMP e;

-- 조회 수 정렬(오름차순-ASC, 내림차순-DESC)
-- sal 내림차순
SELECT ENAME, SAL 
FROM EMP e
ORDER BY SAL DESC;

-- sal 오름차순(asc 생략 가능)
SELECT ENAME, SAL 
FROM EMP e
ORDER BY SAL;

-- empno 내림차순
SELECT * FROM EMP e ORDER BY EMPNO DESC;

-- deptno 오름차순, sal 내림차순
SELECT * 
FROM EMP e 
ORDER BY DEPTNO ASC,SAL DESC;

SELECT
	EMPNO AS "EMPLOYEE_NO",
	ENAME AS "EMPLOYEE_NAME",
	MGR AS "MANAGER",
	SAL AS "SALARY",
	COMM AS "COMMISSION",
	DEPTNO AS "DEPARTMENT-NO"
FROM
	EMP e
ORDER BY
	DEPTNO DESC,
	ENAME ASC;

-- 선택조회
-- 2) 조건 지정
-- SELECT 컬럼나열,... FROM 테이블명 WHERE 조건 나열;

-- 부서번호가 30번인 사원 전체 조회
-- = : 동일하다
SELECT * FROM EMP WHERE DEPTNO = 30;

-- 사원번호가 7839인 사원 조회
-- 사원번호 중복되지 않음
-- where 조건으로 중복되지 않는 값이 사용된다면 결과는 하나만 조회됨
SELECT * FROM emp WHERE EMPNO =7839;

-- 부서번호가 30이고(and) 직책이 salesman인 사원 조회
SELECT * FROM  EMP e WHERE DEPTNO = 30 AND JOB ='SALESMAN';

-- 사원번호가 7698 이고 부서번호가 30인 사원조회
SELECT * FROM EMP e WHERE EMPNO = 7698 AND DEPTNO =30;

-- 부서번호가 30이거나(OR) 사원 직책이 CLERK인 사원 조회
SELECT * FROM EMP e WHERE DEPTNO = 30 OR JOB = 'CLERK';

-- 연봉이 36000인 사원 조회
-- SAL(월급) * 12 = 36000
SELECT * FROM EMP WHERE SAL*12 = 36000;

-- 급여가 3000보다 큰 사원 조회
SELECT * FROM EMP WHERE SAL > 3000;
-- 급여가 3000이상인 사원 조회
SELECT * FROM EMP WHERE SAL >= 3000;

-- ENAME 'F' 이후의 ('F' 포함) 문자열로 시작하는 사원 조회
SELECT * FROM EMP WHERE ENAME >= 'F';

-- 급여가 2500 이상이고 직업이 ANALYST인 사원 조회
SELECT * FROM EMP e WHERE SAL >= 2500 AND JOB ='ANALYST';
-- JOB이 MANAGER, SALESMAN, CLERK 인 사원 조회
SELECT * FROM EMP e WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN' OR JOB = 'CLERK';

--SAL이 3000 이 아닌 사원 조회
-- !=, <>, ^=
SELECT * FROM EMP e WHERE SAL != 3000;
SELECT * FROM EMP e WHERE SAL <> 3000;
SELECT * FROM EMP e WHERE SAL ^= 3000;

-- IN
SELECT * FROM EMP e WHERE JOB IN('MANAGER','SALESMAN','CLERK');

-- JOB이 MANAGER, SALESMAN, CLERK 인 아닌 사원 조회
SELECT * FROM EMP e WHERE JOB <> 'MANAGER' AND JOB != 'SALESMAN' AND JOB ^= 'CLERK';
SELECT * FROM EMP e WHERE JOB NOT IN('MANAGER','SALESMAN','CLERK');

-- 부서번호가 10번 이거나 20번인 사원 조회
SELECT * FROM EMP e WHERE e.DEPTNO IN(10,20);

-- BETWEEN A AND B : 일정 범위 내의 데이터 조회 시 사용
-- 급여가 2000 이상이고 3000이하인 범위 조회
SELECT *
FROM EMP e 
WHERE E.SAL >= 2000 AND E.SAL <=3000;

SELECT *
FROM EMP e 
WHERE E.SAL BETWEEN 2000 AND 3000;

-- NOT BETWEEN A AND B : 일정 범위가 아닌 데이터 조회 시 사용
-- 급여가 2000 이상 3000이하가 아닌 범위 조회
SELECT *
FROM EMP e 
WHERE E.SAL NOT BETWEEN 2000 AND 3000;

-- LIKE 연산자와 와일드 카드(%, _)
-- ENAME = 'JONES' : 전체일치
-- ENAME 이 'J'로 시작하는 OR 'A' 가 들어간 부분일치 = LIKE 

-- 'J%' : 'J'로 시작하면 그 뒤에 어떤 문자가 몇 개가 오던 상관없음
SELECT * FROM EMP WHERE ENAME LIKE 'J%';

-- -J% : 어떤 문자로 시작해도 상관 없으나 개수는 하나 / 두번째 문자는 J / 시작하면 그 뒤에 어떤 문자가 몇 개가 오던 상관없음
SELECT * FROM EMP WHERE ENAME LIKE '_L%';

-- 사원명에 AM 문자가 포함된 사원 조회
SELECT * FROM EMP WHERE ENAME LIKE '%AM%';

-- 사원명에 AM 문자가 포함되지 않는 사원 조회
SELECT * FROM EMP WHERE ENAME NOT LIKE '%AM%';

-- IS NULL
-- SELECT * FROM emp WHERE COMM = NULL;(x)
SELECT * FROM emp WHERE comm IS NULL;
SELECT * FROM emp WHERE comm IS NOT NULL;

-- 집합 연산자
-- UNION : 합집합(결과 값의 중복 제거) 컬럼의 개수/타입이 동일해야함
-- UNION ALL : 합집합(중복)
-- MINUS : 차집합
-- INTETSECT : 교집합

-- 부서번호가 10번인 사원 조회(사번,이름,급여,부서번호)
-- 부서번호가 20번인 사원 조회(사번,이름,급여)
SELECT E.EMPNO,E.ENAME, E.SAL, E.DEPTNO 
FROM EMP E
WHERE E.EMPNO = 10
UNION
SELECT E.EMPNO ,E.ENAME ,E.SAL,E.DEPTNO 
FROM EMP e
WHERE E.DEPTNO = 20;

SELECT E.EMPNO,E.ENAME, E.SAL, E.DEPTNO 
FROM EMP E
WHERE E.EMPNO = 10
UNION ALL
SELECT E.EMPNO ,E.ENAME ,E.SAL,E.DEPTNO 
FROM EMP e
WHERE E.DEPTNO = 10;

SELECT E.EMPNO,E.ENAME, E.SAL, E.DEPTNO 
FROM EMP E
MINUS
SELECT E.EMPNO ,E.ENAME ,E.SAL,E.DEPTNO 
FROM EMP e
WHERE E.DEPTNO = 10;

SELECT E.EMPNO,E.ENAME, E.SAL, E.DEPTNO 
FROM EMP E
INTERSECT
SELECT E.EMPNO ,E.ENAME ,E.SAL,E.DEPTNO 
FROM EMP e
WHERE E.DEPTNO = 10;

-- 함수
-- 1. 오라클 내장 함수
-- 		1)단일행 함수 : 데이터가 한 행 씩 입력되고 입력된 한 행당 결과가 하나씩 나오는 함수
--		2)다중행 함수 : 여러 행이 입력되고 결과가 하나의 행으로 반환되는 함수
-- 2. 사용자 정의 함수(PL/SQL)

-- 1. 문자함수
-- UPPER(문자열) : 괄호 안 문자열을 모두 대문자로
-- LOWER(문자열) : 괄호 안 문자열을 모두 소문자로
-- INITCAP(문자열) : 괄호 안 문자 데이터 중 첫문자만 대문자, 나머지느 소문자로
-- LENGTH(문자열) : 문자열의 길이 
-- LENGTHB(문자열) : 문자열의 바이트 수
-- SUBSTR(문자열,시작위치) / SUBSTR(문자열,시작위치,추출길이)
-- INSTR(문자열,찾으려는 문자) : 특정 문자나 문자열이 어디에 포함되어 있는지
-- INSTR(문자열,찾으려는 문자,위치 찾기를 시작할 대상 문자열 데이터 위치,시작위치에서 찾으려는 문자가 몇 번째인지)
-- REPLACE(문자열,찾는문자,대체문자)
-- CONCAT(문자열1,문자열2) : 문자열 연결
-- TRIM / LTPIM / RTPIM : 특정 문자를 제거(주로 공백 제거 사용)


-- 데이터는 대소문자 구분 함
-- ORACLE = oracle (x)
SELECT E.ENAME,UPPER(E.ENAME),LOWER(E.ENAME),INITCAP(E.ENAME) 
FROM EMP e; 

SELECT * FROM EMP e;

-- ename을 대문자로 출력,대소문 관계 없이 ename의 'smith' 찾기
SELECT *
FROM EMP e 
WHERE UPPER(ENAME) = UPPER('smith'); 

SELECT *
FROM EMP e 
WHERE UPPER(ENAME) LIKE UPPER('%smith%'); 

-- DUAL : 오라클에서 제공하는 기본 테이블(함수 적용 결과 보기(테스트용))
-- LENGTH /LENGTHB
-- 21X 에서는 한글은 3바이트로 출력(버전마다 다름)
SELECT LENGTH ('한글'),LENGTHB('한글'),LENGTH('AB'), LENGTHB('AB')
FROM DUAL;

SELECT JOB, SUBSTR(JOB,1,2),SUBSTR(JOB,3,2),SUBSTR(JOB,5)
FROM EMP;

-- - : 오른쪽 끝을 의미
SELECT JOB, SUBSTR(JOB,-LENGTH(JOB)),SUBSTR(JOB,-LENGTH(JOB),2),SUBSTR(JOB,-3)
FROM EMP;

SELECT
	INSTR('HELLO, ORACLE!', 'L') AS INSTR_1,
	INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2,
	INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3
FROM DUAL;

-- 사원 이름에 S 가 있는 행 구하기
-- LIKE
SELECT * FROM EMP e WHERE E.ENAME LIKE '%S%';
-- INSTR
SELECT * FROM EMP e WHERE INSTR(E.ENAME,'S') > 0;

-- 010-1234-1234
SELECT '010-1234-1234' AS REPLACE_BEFORE,
	REPLACE ('010-1234-1234','-',' ') AS REPLACE_CHANGE,
	REPLACE ('010-1234-1234', '-') AS REPLACE_REMOVE
FROM
	DUAL;
	
-- EMPNO,ENAME 연결 조회
-- CONCAT 단점 두개 연결만 가능/ 다중연결 시 CONCAT(EMPNO,CONCAT(':',ENAME)) 처럼 안에 복합하여 함수 사용
SELECT CONCAT(EMPNO,ENAME),CONCAT(EMPNO,CONCAT(':',ENAME))
FROM EMP e 

-- || :CONCAT과 같은 역할 편함 상위 호환 
SELECT EMPNO || ENAME, EMPNO || ':' || ENAME
FROM EMP e;

SELECT
	'[' || TRIM(' _Oracle_ ') || ']' AS TRIM,
	'[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
	'[' || LTRIM(' <_Oracle_> ' , '_<') || ']' AS LTRIM2,
	'[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
	'[' || RTRIM(' <_Oracle_> ' , '>_') || ']' AS RTRIM2
FROM
	DUAL;
	
-- 숫자함수
-- ROUND(숫자,[반올림위치])
-- TRUNC(숫자,[버림위치])
-- CEIL(숫자) : 지정한 숫자와 가장 가까운 정수 큰 찾기
-- FLOOR(숫자) : 지정한 숫자와 가장 가까운 작은 정수 찾기
-- MOD(숫자,나눌숫자)==%

SELECT
	TRUNC(1234.5678) AS TRUNC, 
	TRUNC(1234.5678, 0) AS TRUNC_0, 
	TRUNC(1234.5678, 1) AS TRUNC_1, 
	TRUNC(1234.5678, 2) AS TRUNC_2, 
	TRUNC(1234.5678, -1) AS TRUNC_MINUS1,
	TRUNC(1234.5678, -2) AS TRUNC_MINUS2
FROM
	DUAL;

SELECT CEIL(3.14),FLOOR(3.14),CEIL(-3.14),FLOOR(-3.14)
FROM DUAL;

SELECT MOD(15,6)
FROM DUAL;

-- 날짜 함수
-- SYSDATE : 오라클 서버가 설치되 os 의 현재날짜와 시간 사용
-- 날짜데이터 + 숫자 : 날짜 데이터와 숫자만큼 일수 이후의 날짜
-- 날짜데이터 - 날짜데이터 : 일수 차이
-- 날짜데이터 + 날짜데이터 (x)
-- ADD-MONTH(날짜데이터,개월수) : + 개월수 출력
-- MONTH_BETWEEN(날짜데이터,날짜데이터) : 두 날짜 데이터 간의 차이를 개월 수로 계산
-- NEXT_DAY(날짜데이터,요일문자): 날짜 데이터에서 돌아오는 요일의 날짜 반환
-- LAST_DAY(날짜데이터) : 특정 날짜가 속한 달의 마지막 날짜 조회

SELECT SYSDATE FROM dual;

SELECT SYSDATE ,SYSDATE-1,SYSDATE+1 FROM dual;

SELECT SYSDATE,ADD_MONTHS(SYSDATE,3) FROM dual;

-- 입사 20주년 조회
SELECT EMPNO,ENAME,HIREDATE ,ADD_MONTHS(HIREDATE ,240) FROM EMP e; 

SELECT
	EMPNO,
	ENAME,
	HIREDATE,
	SYSDATE ,
	MONTHS_BETWEEN(HIREDATE , SYSDATE) AS MONTH1,
	MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTH2,
	TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH3
FROM
	EMP e; 
SELECT SYSDATE,NEXT_DAY(SYSDATE,'월요일'),LAST_DAY(SYSDATE) FROM DUAL;	

--형변화 함수
-- TO_CHAR(날짜데이터,'출력되길 원하는 문자형태')
-- TO_NUMBER(문자데이터,'인식되길 원하는 숫자 형태')
-- TO_DATE(문자데이터,'인식되길 원하는 날짜형태')

-- NUMBER + '문자 숫자' = 연산함
SELECT E.EMPNO ,E.ENAME ,E.EMPNO +'500'
FROM EMP e;

--수치가 부적합합니다
--SELECT E.EMPNO ,E.ENAME ,E.EMPNO +'abcd'
--FROM EMP e;

-- 날짜데이터 => 문자데이터
-- 자바 월 mm / 분 MM
-- 오라클 월 MM / 분 MI
SELECT SYSDATE ,TO_CHAR(SYSDATE,'YYYY/MM/DD') AS 현재날짜 
FROM DUAL;

SELECT TO_CHAR(SYSDATE,'MM') AS 현재월, TO_CHAR(SYSDATE,'MON') AS 현재월2, TO_CHAR(SYSDATE,'MONTH')AS 현재월3 
FROM DUAL;

-- DD,DDD,DAY
SELECT TO_CHAR(SYSDATE,'DD')AS 일자1 ,TO_CHAR(SYSDATE,'DAY')AS 일자2
FROM DUAL;

SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'HH:MI:SS')AS 현재시간 ,
	TO_CHAR(SYSDATE, 'HH12:MI:SS')AS 현재시간2,
	TO_CHAR(SYSDATE, 'HH24:MI:SS')AS 현재시간3,
	TO_CHAR(SYSDATE, 'HH24:MI:SS AM')AS 현재시간4
FROM
	DUAL;

-- 문자데이터 => 숫자데이터
SELECT 1300 - '1500','1300'+1500
FROM DUAL;

SELECT '1300' + '1500'
FROM DUAL;

--수치가 부적합합니다(,가 포함되면 문자로 처리)
--SELECT '1,300' + '1500'
--FROM DUAL;

--9(숫자 한자리을 의미 : 빈자리는 채우지 않음) OR 0(숫자 한자리 : 빈자리를 채움)
SELECT TO_NUMBER('1,300','999,999') + TO_NUMBER('1,500','999,999')
FROM DUAL;

-- 문자데이터 => 날짜데이터
SELECT TO_DATE('2024-09-05','YYYY-MM-DD') AS TODATE1, TO_DATE('20240905','YYYY-MM-DD') AS TODATE2
FROM DUAL;

-- EMP 테이블에서 1981-06-01 입사한 사원 조회
SELECT * 
FROM EMP e
WHERE E.HIREDATE >= '1981-06-01';

SELECT * 
FROM EMP e
WHERE E.HIREDATE >= TO_DATE('1981-06-01','YYYY-MM--DD');

-- 날짜데이터 + 날짜데이터
SELECT '2024-09-05' + '2024-01-02'
FROM DUAL;

--날짜와 날짜의 가산은 할 수 없습니다
--SELECT TO_DATE('2024-09-05') +TO_DATE('2024-01-02')
--FROM DUAL;

SELECT TO_DATE('2024-09-05') -TO_DATE('2024-01-02')
FROM DUAL;

-- NULL 처리 함수
-- NULL 과 산술연산은 안됌 => NULL을 다른 값으로 변경
-- NVL(널값,대체할값)
-- NVL2(널값,널이아닌경우반환값,널인경우반환값)
-- SAL = NULL(X) IS NULL(O)

SELECT E.EMPNO, E.ENAME ,E.SAL ,E.COMM ,E.SAL+NVL(E.COMM,0) 
FROM EMP e ;

-- 널이 아니면 SAL*12+COMM
-- 널이면 SAL*12
SELECT E.EMPNO, E.ENAME ,E.SAL ,E.COMM ,NVL2(E.COMM, 'O','X'),NVL2(E.COMM, E.SAL*12+COMM,SAL*12)
FROM EMP e;

-- DECODE 함수 / CASE 문
--DECODE(데이터,
--		조건1,조건1을 만족할때 해야할것,
--		조건2,조건2을 만족할때 해야할것,
--		) AS 별칭

-- JOB이 MANAGER라면 SAL*1.1
-- JOB이 SALESMAN 이라면 SAL*1.5
-- JOB이 ALALYST이라면 SAL
--		그 외 라면 SAL * 1.03

SELECT
	E.EMPNO ,
	E.ENAME ,
	E.JOB ,
	E.SAL,
	DECODE(JOB,'MANAGER',E.SAL*1.1,
	'SALESMAN',E.SAL*1.5,
	'ALALYST',E.SAL,
	E.SAL * 1.03) AS UPSAL
FROM
	EMP e;
	
SELECT
	E.EMPNO ,
	E.ENAME ,
	E.JOB ,
	E.SAL,
	CASE
		JOB
	WHEN 'MANAGER' THEN E.SAL * 1.1
		WHEN 'SALESMAN' THEN E.SAL * 1.5
		WHEN 'ALALYST' THEN E.SAL
		ELSE E.SAL * 1.03
	END AS UPSAL
FROM
	EMP e;
	
-- COMM 널일때 '해당사항없음'
-- COMM = 0 일때 '수당없음'
-- COMM > 0 일때 '수당 : COMM'
SELECT
	E.EMPNO ,
	E.ENAME ,
	E.COMM ,
	CASE
		WHEN E.COMM IS NULL THEN '해당사항없음'
		WHEN E.COMM = 0 THEN '수당없음'
		WHEN E.COMM > 0 THEN '수당 :' || E.COMM 
	END AS COMM_TEXT
FROM
	EMP e;

-- EMP 테이블에서 사원들의 월 평균 근무일수는 21.5일이다. 하루 근무시간을 8시간을 봤을때
-- 사원들의 하루 급여(DAY_PAY)와 시급(TIME_PAY)를 계산하여 결과를 출력한다.
-- 사번,이름,SAL,DAY_PAY,TIME_PAY출력
-- 단, 하루급여는 소수점 셋째자리에서 버리고, 시급은 두번째 소수점에서 반올림하기
SELECT
	E.EMPNO,
	E.ENAME,
	E.SAL,
	TRUNC(E.SAL / 21.5,2)AS DAY_PAY ,
	ROUND(E.SAL / 21.5 / 8, 1)AS TMIE_PAY
FROM
	EMP e;
	
-- EMP 테이블에서 사원들은 입사일을 기준으로3개월이 지난 후 첫 월요일에 정직원이 된다.
-- 사원들의 정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 출력한다.
-- 사번,이름,고용일,R_JOB 출력
SELECT 
	E.EMPNO, 
	E.ENAME,
	E.HIREDATE,
	NEXT_DAY(ADD_MONTHS(E.HIREDATE,3),'월요일') AS R_JOB
FROM EMP e 

-- + 추가수당
-- COMM 이 없으면 'N/A', 있으면 COMM 출력
SELECT 
	E.EMPNO, 
	E.ENAME,
	E.HIREDATE,
	NEXT_DAY(ADD_MONTHS(E.HIREDATE,3),'월요일') AS R_JOB,
	CASE
		WHEN E.COMM IS NULL THEN 'N/A'
		WHEN E.COMM IS NOT NULL THEN E.COMM || ''
	END AS COMM
FROM EMP e; 

-- ORA-01722: 수치가 부적합합니다
SELECT E.COMM, NVL(E.COMM,'N/A')
FROM EMP e;

-- NVL
SELECT 
	E.EMPNO, 
	E.ENAME,
	E.HIREDATE,
	NEXT_DAY(ADD_MONTHS(E.HIREDATE,3),'월요일') AS R_JOB,
	NVL(TO_CHAR(E.COMM),'N/A') AS COMM
FROM EMP e; 

-- EMP 테이블의 모든 사원을 대상으로 직속 사원의 사원번호(MGR)를 변환해서 CHG_MGR에 출력
-- 사번,이름,MGR,CHG_MGR 출력
-- CHF_MGR 조건
-- MGR이 널이면 '0000'/MGR의 앞자리 두자리가 75이면 '5555'/76이면'6666'/77이면 '7777'/78이면 '8888'출력
SELECT 
	e.EMPNO,
	e.ENAME,
	e.MGR,
	DECODE(SUBSTR(TO_CHAR(E.MGR),1,2),
		NULL,'0000',
		'75','5555',
		'76','6666',
		'77','7777',
		'78','8888',
		SUBSTR(TO_CHAR(E.MGR),1)
	)AS CHG_MGR
FROM EMP e;

SELECT 
	e.EMPNO,
	e.ENAME,
	e.MGR,
	CASE 
		WHEN E.MGR IN NULL THEN '0000'
		WHEN E.MGR LIKE '75%' THEN '5555'
		WHEN E.MGR LIKE '76%' THEN '6666'
		WHEN E.MGR LIKE '77%' THEN '7777'
		WHEN E.MGR LIKE '78%' THEN '8888'
		ELSE SUBSTR(TO_CHAR(E.MGR), 1)
	END AS CHG_MGR
FROM
	EMP e;

-- 다중행 함수
-- SUM(합계를 낼 열), COUNT(), MAX(), MIN(), AVG()
-- DISTINCT : 중복제거

SELECT SUM(SAL)
FROM EMP e; 

SELECT SUM(DISTINCT SAL),SUM(ALL SAL),SUM(SAL)
FROM EMP e; 

SELECT COUNT(DISTINCT SAL),COUNT(ALL SAL),COUNT(SAL)
FROM EMP e; 

SELECT MAX(SAL),MIN(SAL)
FROM EMP e;

SELECT MAX(SAL),MIN(SAL)
FROM EMP e
WHERE E.DEPTNO =10;

-- 부서번호가 20번인 사원의 최근 입사일 조회
SELECT MAX(E.HIREDATE)
FROM EMP e
WHERE E.DEPTNO = 20;

SELECT MIN(E.HIREDATE)
FROM EMP e
WHERE E.DEPTNO = 20;  

SELECT AVG(DISTINCT SAL),AVG(ALL SAL),AVG(SAL)
FROM EMP e; 

-- 부서번호가 30번인 사원 들의 평균 추가 수당
SELECT AVG(E.COMM)
FROM EMP e
WHERE E.DEPTNO = 30;

-- GROUP BY : 결과 값을 원하느 열로 묶어 출력
-- GROUP BY 그룹화할 열
-- 각 부서별 평균 급여 출력
SELECT
	DEPTNO ,
	AVG(SAL)
FROM EMP
GROUP BY
	DEPTNO
ORDER BY
	DEPTNO;
-- 각부서별, 직책별 평균 급여 출력
SELECT
	DEPTNO ,
	JOB,
	AVG(SAL)
FROM EMP
GROUP BY
	DEPTNO,JOB
ORDER BY
	DEPTNO,JOB;

-- GROUP BY 표현식이 아닙니다.(GROUP BY 절을 사용할 때에는 SELECT 절에서 사용할수 있는 열이 제한됨)
-- SELECT 가능: ㅎGROUP BY 쓰여진 열,다중행함수
--SELECT ENAME,AVG(SAL)
--FROM EMP
--GROUP BY DEPTNO;

--GROUP BY ~ HAVING : 그룹바이 절에 조건을 줄때 사용
-- 각 부서의 직책별 평균 급여(평균 급여가 2000이상인 그룹만 조회)
SELECT
	DEPTNO,
	JOB,
	AVG(SAL)
FROM
	EMP e
GROUP BY
	DEPTNO,
	JOB
HAVING
	AVG(SAL) >= 2000
ORDER BY 
	DEPTNO,
	JOB;


--ORA-00934: 그룹 함수는 허가되지 않습니다
--SELECT DEPTNO,JOB,AVG(SAL)
--FROM EMP e
--WHERE AVG(SAL)>=2000
--GROUP BY DEPTNO,JOB
--ORDER BY DEPTNO,JOB;

-- 부서별,평균급여,최고급여,최저급여,사원 수 출력
-- 평균급여 출력시 소수점을 제외하고 출력
SELECT E.DEPTNO,FLOOR(AVG(SAL)),MAX(SAL),MIN(SAL),COUNT(DEPTNO) 
FROM EMP e 
GROUP BY E.DEPTNO
ORDER BY E.DEPTNO;

-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수 출력
SELECT JOB,COUNT(JOB)
FROM EMP e
GROUP BY JOB
HAVING COUNT(ALL JOB) >= 3
ORDER BY JOB;

-- 사원들의 입사년도 기준으로 부서별로 몇 명의 입사인원이 있는지 출력
-- 1987 20 2(1987년도 20번 부서에 2명 입사)
SELECT TO_CHAR(E.HIREDATE,'YYYY') AS HIRE_DATE ,DEPTNO,COUNT(*)AS CNT 
FROM EMP e 
GROUP BY TO_CHAR(E.HIREDATE,'YYYY'),DEPTNO
ORDER BY DEPTNO ;

-- JOIN(조인) : 두 개이상의 테이블을 연결하여 하나의 테이블처럼 출력
-- 내부조인
--   등가조인(*) : 테이블 연결 후 출력 행을 각 테이블의 특정 열에 일치한 데이터를 기준으로 선정
--   비등가조인
-- 외부조인

--SELECT * FROM EMP,DEPT;

--1)내부조인
--등가조인 :EMP 테이블의 DEPTNO와 DEPT테이블의 DEPTNO가 일치 시 연결
-- 앞에있는 테이블 기준으로 끌어옴

--열의 정의가 애매합니다 : 중복 컬럼이 존재시 정확한 필드명 작성
SELECT E.EMPNO ,E.ENAME ,D.DEPTNO ,D.DEPTNO ,D.LOC 
FROM EMP e ,DEPT d 
WHERE E.DEPTNO=D.DEPTNO; 




-- SQL 퀴리문은 대소문자를 구별하지 않음 단, 비밀번호는 구별
-- DML 
-- 1) 조회
-- SELECT 컬럼명 -------- 5)
-- FROM 테이블명 --------- 1)
-- WHERE 조건절 --------- 2)
-- GROUP BY 컬럼명 ------ 3)
-- HAVING 집계함수 조건절 -- 4)
-- ORDER BY 컬럼명... ----6)

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
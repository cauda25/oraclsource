-- 사용자 생성 시 특정 문자열로 시작하는 user 생성을 안하겠음
-- hr(c##hr)
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- 뷰는 어드민에서만 권한부여가 가능
-- SCOTT에게 뷰 권한 부여
GRANT CREATE VIEW TO SCOTT;
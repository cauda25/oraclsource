--movie ,review 조인
--mno,title,regdate(movie)
--review 수 , 평균(review)

SELECT mi.mno, AVG(mr.GRADE),COUNT(mr.RNO)
FROM MOVIE_ID mi left JOIN MOVIE_REVIEW mr on mi.MNO = mr.MOVIE_MNO GROUP BY mi.MNO;

SELECT MR.MOVIE_MNO, AVG(mr.GRADE),COUNT(mr.GRADE) 
FROM MOVIE_REVIEW mr 
GROUP BY mr.MOVIE_MNO; 

SELECT
	mi.MNO ,
	mi.TITLE ,
	review.movie_mno,
	review.cnt,
	review.avg,
	mi.regdate
FROM
	MOVIE_ID mi
LEFT JOIN (
	SELECT
		MR.MOVIE_MNO AS movie_mno,
		AVG(mr.GRADE) AS avg,
		COUNT(mr.GRADE) AS cnt
	FROM
		MOVIE_REVIEW mr
	GROUP BY
		mr.MOVIE_MNO
) review ON
	mi.MNO = review.MOVIE_MNO;

--movie,review 서브 쿼리
SELECT
	mi.mno,
	mi.TITLE,
	mi.REGDATE,
	(
	SELECT
		AVG(mr.GRADE)
	FROM
		MOVIE_REVIEW mr
	WHERE
		mr.movie_mno = mi.MNO) avg,
	(
	SELECT
		COUNT(mr.RNO)
	FROM
		MOVIE_REVIEW mr
	WHERE
		mr.movie_mno = mi.MNO) cnt
FROM
	MOVIE_ID mi; 
	

--movie ,review,movie_image 조인 or 서브쿼리
--mno,title,regdate(movie)
--review 수 , 평균(review)
--inum ,path,uuid,img_name max(inum) 기준 movie_mno
SELECT
	mi.MNO ,
	mi.TITLE ,
	mi.regdate
FROM
	MOVIE_ID mi
LEFT JOIN MOVIE_IMAGE mi2 on 
	mi.MNO = mi2.MOVIE_MNO;

SELECT mi.MOVIE_MNO ,MAX(INUM) 
FROM MOVIE_IMAGE mi 
GROUP BY mi.MOVIE_MNO; 



SELECT
	mi.MNO ,
	mi.TITLE ,
	review.movie_mno,
	review.cnt,
	review.avg,
	mi.regdate,
	image.max
FROM
	MOVIE_ID mi
LEFT JOIN (
	SELECT
		MR.MOVIE_MNO AS movie_mno,
		AVG(mr.GRADE) AS avg,
		COUNT(mr.GRADE) AS cnt
	FROM
		MOVIE_REVIEW mr
	GROUP BY
		mr.MOVIE_MNO
) review ON
	mi.MNO = review.MOVIE_MNO
LEFT JOIN (
	SELECT
		mmi.MOVIE_MNO ,
		MAX(INUM)AS max
	FROM
		MOVIE_IMAGE mmi
	GROUP BY
		mmi.MOVIE_MNO)image
ON
	mi.MNO = image.MOVIE_MNO; 



SELECT
	mi.mno,
	mi.TITLE,
	mi.REGDATE,
	(
	SELECT
		AVG(mr.GRADE)
	FROM
		MOVIE_REVIEW mr
	WHERE
		mr.movie_mno = mi.MNO) avg,
	(
	SELECT
		COUNT(mr.RNO)
	FROM
		MOVIE_REVIEW mr
	WHERE
		mr.movie_mno = mi.MNO) cnt,mi3.IMG_NAME,mi3.INUM,mi3."PATH",MI3.UUID 
FROM
	MOVIE_ID mi LEFT JOIN MOVIE_IMAGE mi3 ON mi.mno = mi3.MOVIE_MNO 
		WHERE mi3.INUM IN (SELECT MAX(mi2.inum) FROM MOVIE_IMAGE mi2 GROUP BY mi2.movie_mno);
	
	
	SELECT
	mi.mno,
	mi.TITLE,
	mi.REGDATE,
	(
	SELECT
		AVG(mr.GRADE)
	FROM
		MOVIE_REVIEW mr
	WHERE
		mr.movie_mno = mi.MNO) avg,
	(
	SELECT
		COUNT(mr.RNO)
	FROM
		MOVIE_REVIEW mr
	WHERE
		mr.movie_mno = mi.MNO) cnt,mi3.IMG_NAME,mi3.INUM,mi3."PATH",MI3.UUID 
FROM
	MOVIE_ID mi LEFT JOIN MOVIE_IMAGE mi3 ON mi.mno = mi3.MOVIE_MNO 
		WHERE mi.MNO = 4;
	
	
-- 닉네임 변경
UPDATE MOVIE_MEMBER
SET NICKNAME = 'starbucks'
WHERE EMAIL ='usermail1@email.com';


-- 비밀번호 변경
UPDATE MOVIE_MEMBER
SET PASSWORD = '1234'
WHERE EMAIL ='usermail1@email.com'AND PASSWORD ='1111';

-- 회원 탈퇴(리뷰 삭제,회원 탈퇴)
DELETE FROM MOVIE_REVIEW mr 
WHERE ri.member_mmid = 50;

DELETE
FROM
	MOVIE_MEMBER mm
WHERE
	mm.email = 'usermai50@email.com'
	AND mm.password = '$10$/6WgVv7C7mHtzuROdiVGHurj7PIABIGyyXzJ5Zzv0zWkqXFqb0qqq';
	

SELECT * FROM MOVIE_IMAGE mi WHERE mi."PATH" = TO_CHAR(SYSDATE-1,'yyyy/mm/dd'); 


--ex22_union.sql

/*

	관계 대수 연산
	1. 셀렉션 > select where
	2. 프로젝션 > select column
	3. 조인
	4. 합집합(union), 차집합(minus), 교집합(intersect)
	
	
	유니온, union
	- 스키마가 동일한 결과셋끼리 가능

*/

SELECT * FROM tblmen
UNION
SELECT * FROM tblwomen;

SELECT name, address, salary FROM tblstaff
UNION
SELECT name, city, basicpay FROM tblinsa;

-- 어떤 회사 > 부서별 게시판
SELECT * FROM 영업부게시판;
SELECT * FROM 총무부게시판;
SELECT * FROM 개발부게시판;

-- 회장님 > 모든 부서의 게시판글 > 한번에 열람
SELECT * FROM 영업부게시판
UNION 
SELECT * FROM 총무부게시판
UNION
SELECT * FROM 개발부게시판;

-- 야구선수 > 공격수, 수비수
SELECT * FROM 공격수;
SELECT * FROM 수비수;

SELECT * FROM 공격수
UNION 
SELECT * FROM 수비수;

-- SNS > 하나의 테이블 + 다량의 데이터 > 기간별 테이블 분할

SELECT * FROM 게시판2020;
SELECT * FROM 게시판2021;
SELECT * FROM 게시판2022;
SELECT * FROM 게시판2023;

SELECT * FROM 게시판2020
UNION
SELECT * FROM 게시판2021
UNION
SELECT * FROM 게시판2022
UNION
SELECT * FROM 게시판2023;

--
CREATE TABLE tblAAA(
	name varchar2(30) NOT NULL
);

CREATE TABLE tblBBB(
	name varchar2(30) NOT NULL
);


INSERT INTO tblaaa VALUES ('강아지');
INSERT INTO tblaaa VALUES ('고양이');
INSERT INTO tblaaa VALUES ('토끼');
INSERT INTO tblaaa VALUES ('거북이');
INSERT INTO tblaaa VALUES ('병아리');

INSERT INTO tblbbb VALUES ('강아지');
INSERT INTO tblbbb VALUES ('고양이');
INSERT INTO tblbbb VALUES ('호랑이');
INSERT INTO tblbbb VALUES ('사자');
INSERT INTO tblbbb VALUES ('코끼리');

-- union > 수학의 집합 > 중복 제거
SELECT * FROM TBLAAA
UNION
SELECT * FROM tblbbb;

-- union all > 중복값 허용
SELECT * FROM TBLAAA
UNION ALL
SELECT * FROM tblbbb;

-- intersect > 교집합
SELECT * FROM TBLAAA
INTERSECT 
SELECT * FROM TBLBBB;

-- minus > 차집합(A - B)
SELECT * FROM TBLAAA
MINUS 
SELECT * FROM TBLBBB;

SELECT * FROM TBLBBB
MINUS 
SELECT * FROM TBLAAA;


















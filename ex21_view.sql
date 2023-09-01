--ex21_view.sql

/*

	View, 뷰
	- 데이터베이스 객체 중 하나(테이블, 제약사항, 뷰, 시퀀스)
	- 가상 테이블, 뷰 테이블 등..
	- 테이블처럼 사용한다.(***)
	- 쿼리의 양을 줄인다.
	
	- 정의: 쿼리(SQL)을 저장하는 객체
	- 목적: 권한 통제
	
	create [or replace] view 뷰이름
	as
	select 문;



*/

CREATE OR REPLACE VIEW vwinsa
AS 
SELECT * FROM tblinsa;

SELECT * FROM vwInsa; --tblinsa 테이블의 복사본 > 실명 뷰
SELECT * FROM (SELECT * FROM tblinsa); -- > 익명 뷰 
-- '영업부 ' 직원

CREATE OR REPLACE VIEW 영업부
AS
SELECT 
	num, name, city, basicpay, substr(ssn, 8) AS ssn
FROM tblinsa 
	WHERE buseo = '영업부';

SELECT * FROM 영업부;


-- 비디오 대여점 사장 > 날마다 > 업무
CREATE OR REPLACE VIEW vwCheck
AS 
SELECT
	m.name AS 회원,
	v.name AS 비디오,
	r.rentdate AS 언제,
	r.retdate AS 반납,
	r.rentdate + g.period AS 반납예정일,
	sysdate - (r.rentdate + g.period) AS 연체일,
	(sysdate - (r.rentdate + g.period)) * g.price * 0.1 AS 연체료
FROM tblrent r
	INNER JOIN tblvideo v
		ON r.video = v.seq
			INNER JOIN tblmember m
				ON m.seq = r.MEMBER
					INNER JOIN tblgenre g
						ON g.seq = v.genre;

SELECT * FROM tblgenre;			
			
SELECT * FROM vwCheck;

-- tblinsa > 서울 직원 > view
CREATE OR REPLACE VIEW vwSeoul
AS
SELECT * FROM tblinsa WHERE city = '서울'; -- 뷰를 만드는 시점 > 20명

SELECT * FROM vwSeoul; --20명

UPDATE tblinsa SET city = '제주' WHERE num IN (1001, 1005, 1008);

SELECT * FROM tblinsa WHERE city = '서울';

SELECT * FROM vwSeoul; --17명

-- 신입사원 > 업무 > 연락처 확인 > 문자 발송!! hr(java1234)
SELECT * FROM tblinsa; 	--신입 계정 > tblinsa 접근 권한(X)
SELECT * FROM vwTel;	--신입 계정 > vwTest 접근 읽기 권한(O)

CREATE OR REPLACE VIEW vwTel
AS
SELECT name, buseo, jikwi, tel FROM tblinsa;


-- 뷰 사용 주의점 !!
-- 1. SELECT > 실행 O > 뷰는 읽기 전용으로 사용한다. == 읽기 전용 테이블
-- 2. INSERT > 실행 O > 절대 사용 금지
-- 1. UPDATE > 실행 O > 절대 사용 금지
-- 1. DELETE > 실행 O > 절대 사용 금지

CREATE OR REPLACE VIEW vwtodo -- 단순뷰 > 뷰의 select가 1개의 테이블로 구성
AS
SELECT * FROM tbltodo;

SELECT * FROM vwtodo;
INSERT INTO vwtodo VALUES ((SELECT max(seq) + 1 FROM tbltodo), '할일', sysdate, null);
UPDATE vwtodo SET title = '할일 완료' WHERE seq = 25;
DELETE vwtodo WHERE seq = 25;

--복합뷰

SELECT * FROM vwtodo;
SELECT * FROM vwcheck;


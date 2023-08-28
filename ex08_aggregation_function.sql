--ex08_aggregation_function.sql
/*
	
	함수, function
	1. 내장형 함수(Built-in Function)
	2. 사용자 정의 함수(User Function) > ANSI-SQL(X), PL/SQL(O)

	집계 함수, Aggregation Function(******************)
	- 아주 쉬움 > 뒤에 나오는 수업과 결합 > 꽤 어려움 ;;
	1. count()
	2. sum()
	3. avg()
	4. max()
	5. min()
	
	1. count()
	- 결과 테이블의 레코드 수를 반환한다.
	- number count(컬럼명)
	- null 값은 카운트에서 제외된다.(****)
*/

--tblCountry. 총 나라 몇개국?
SELECT count(*) FROM TBLCOUNTRY; --14(모든 레코드, 일부 컬럼에 null 무관)
SELECT count(name) FROM TBLCOUNTRY; --14
SELECT count(population) FROM TBLCOUNTRY; --13

SELECT * FROM TBLCOUNTRY;

SELECT * FROM TBLCOUNTRY; --14
SELECT name FROM TBLCOUNTRY; --14
SELECT population FROM TBLCOUNTRY; --13

-- 모든 직원 수 ?
SELECT count(*) FROM tblinsa;

-- 연락처가 있는 직원수?
SELECT count(tel) FROM TBLINSA;

--연락처가 없는 직원수?
SELECT count(*) - count(tel) FROM tblinsa;

SELECT count(*) FROM tblinsa WHERE tel IS NOT NULL;
SELECT count(*) FROM tblinsa WHERE tel IS NULL;

-- tblInsa. 어떤 부서들이 있나요?
SELECT DISTINCT buseo FROM tblinsa;
-- tblInsa. 부서가 총 몇 개?
SELECT count (DISTINCT buseo) FROM tblinsa;


-- tblComedian. 남자수? 여자수?
SELECT * FROM TBLCOMEDIAN;

SELECT count(*) FROM TBLCOMEDIAN WHERE GENDER = 'm';
SELECT count(*) FROM TBLCOMEDIAN WHERE GENDER = 'f';

-- 남자수 + 여자수 > 1개의 테이블로 가져오시오.
SELECT
	count(CASE
		WHEN GENDER = 'm' THEN 1
	END)AS 남자인원수,
	count(CASE
		WHEN GENDER = 'f' THEN 1
	END)AS 여자인원수
FROM tblcomedian;

-- tblInsa. 기획부 몇명?, 총무부 몇명?, 개발부 몇명?, 총인원?, 나머지부서 몇명?
SELECT count(*) FROM tblinsa WHERE BUSEO = '기획부'; --7
SELECT count(*) FROM tblinsa WHERE BUSEO = '총무부'; --7
SELECT count(*) FROM tblinsa WHERE BUSEO = '개발부'; --14


SELECT
	CASE
		WHEN buseo = '기획부' THEN 'O'
	END,
	CASE
		WHEN buseo = '총무부' THEN 'O'
	END,
	CASE
		WHEN buseo = '개발부' THEN 'O'
	END
FROM tblinsa;


SELECT
	count(CASE
		WHEN buseo = '기획부' THEN 'O'
	END) AS 기획부수,
	count(CASE
		WHEN buseo = '총무부' THEN 'O'
	END) AS 총무부수,
	count(CASE
		WHEN buseo = '개발부' THEN 'O'
	END) AS 개발부수,
	count(*) AS 전체인원수,
	count(
		CASE
			WHEN buseo NOT IN ('기획부', '총무부', '개발부') THEN 'O'
		END
	)AS 나머지인원수
FROM tblinsa;
	








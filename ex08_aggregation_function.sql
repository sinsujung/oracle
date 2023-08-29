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
	
/*
 
 	2. sum()
 	- 해당 컬럼의 합을 구한다.
 	- number sum(컬럼명)
 	- 해당 컬럼 > 숫자형만 가능
 	 	
 */

SELECT * FROM TBLCOMEDIAN;
SELECT sum(height), sum(weight) FROM TBLCOMEDIAN;
SELECT sum(first) FROM TBLCOMEDIAN; --ORA-01722: invalid number


SELECT
	sum(BASICPAY) AS "지출 급여 합",
	sum(SUDANG) AS "지출 수당 합",
	sum(basicpay) + sum(sudang) AS "총 지출",
	sum(basicpay + sudang) AS "총 지출"
FROM tblinsa;
	

-- SELECT sum(*) FROM tblinsa;(X)

/*
 
 
 	3. avg()
 	- 해당 컬럼의 평균값을 구한다.
 	- number avg(컬럼명)
 	- 숫자형만 적용 가능
 	- 해당 컬럼의 평균 값을 구한다.
 */

-- tblInsa. 평균 급여?
SELECT sum(basicpay) / 60 FROM tblinsa;
SELECT sum(basicpay) / count(*) FROM tblinsa;
SELECT avg(basicpay) FROM tblinsa;

--tblCountry, 평균 인구수?
SELECT avg(population) FROM TBLCOUNTRY; 			--15588
SELECT sum(population)/ count(*) FROM TBLCOUNTRY; 	--14475
SELECT sum(population)/ count(population) FROM TBLCOUNTRY;
SELECT count(population), count(*) FROM TBLCOUNTRY;

-- 회사 > 성과급 지급 > 출처 > 1팀 공로~
-- 1. 균등 지급: 총지급액 / 모든 직원수 = sum() / count(*)
-- 2. 차등 지급: 총지급액 / 1팀 직원수 = sum() / count(1팀) = avg()

SELECT avg(name) FROM TBLINSA;
SELECT avg(ibsadate) FROM TBLINSA;

/*
 	
 	
 	4. max()
		- object max(컬럼명)
		- 최댓값 반환
 	 	
 	5. min()
 		- object min(컬럼명)
 		- 최솟값 반환
 		
 		- 숫자형, 문자형, 날짜형 모두 적용 가능
 	  
 */

SELECT max(sudang), min(sudang) FROM TBLINSA; 		--숫자형
SELECT max(name), min(name) FROM TBLINSA; 			--문자형
SELECT max(ibsadate), min(ibsadate) FROM TBLINSA;	--날짜형

SELECT
	count(*) AS 직원수,
	sum(basicpay) AS 총급여합,
	avg(basicpay) AS 평균급여,
	max(basicpay) AS 최고급여,
	min(basicpay) AS 최저급여
FROM TBLINSA;



-- 집계 함수 사용 시 주의점 !!

-- 1.  ORA-00937: not a single-group group function
-- 컬럼 리스트에서는 집계함수와 일반컬럼을 동시에 사용할 수 없다.
SELECT count(*) FROM tblinsa; 	--직원수
SELECT name FROM tblinsa;		--직원명

-- 요구사항] 직원들 이름과 총직원수를 가져오시오.
SELECT count(*), name FROM tblinsa; 

-- 2. ORA-00934: group function is not allowed here
-- where절에는 집계 함수를 사용할 수 없다. 
-- 집계 함수(집합), 컬럼(개인)
-- where절 > 개개인(레코드)의 데이터를 접근해서 조건검색 > 집합값 호출 불가

-- 요구사항] 평균 급여보다 더 많이 받는 직원들?
SELECT avg(basicpay) FROM tblinsa; 

SELECT * FROM tblinsa WHERE basicpay >= avg(basicpay);









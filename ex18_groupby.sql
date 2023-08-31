-- ex18_groupby.sql

/*

	[WITH <Sub Query>]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expression [ASC|DESC]]

	select 컬럼리스트		4. 컬럼 지정(보고 싶은 컬럼만 가져오기) > Profection
	from 테이블			1. 테이블 지정
	where 조건 			2. 조건 지정(보고 싶은 행만 가져오기) > Selection
	group by 기준			3. (레코드끼리) 그룹을 나눈다.
	order by 정렬기준; 	5. 순서대로
	

*/

-- tblInsa. 부서별 평균 급여?
SELECT * FROM tblinsa;

SELECT round(avg(BASICPAY)) FROM tblinsa; -- 155마눤, 전체 60명의 평균

SELECT DISTINCT buseo FROM TBLINSA; --7개

SELECT round(avg(BASICPAY)) FROM tblinsa WHERE buseo = '총무부'; --171
SELECT round(avg(BASICPAY)) FROM tblinsa WHERE buseo = '개발부'; --138
SELECT round(avg(BASICPAY)) FROM tblinsa WHERE buseo = '영업부'; --160
SELECT round(avg(BASICPAY)) FROM tblinsa WHERE buseo = '기획부'; --185
SELECT round(avg(BASICPAY)) FROM tblinsa WHERE buseo = '인사부'; --153
SELECT round(avg(BASICPAY)) FROM tblinsa WHERE buseo = '자재부'; --141
SELECT round(avg(BASICPAY)) FROM tblinsa WHERE buseo = '홍보부'; --145


-- *** group by 목적 > 그룹별 통계값을 구하기 위해서!!!! > 집계 함수 사용

SELECT
	BUSEO,
	count(*) AS "부서별 인원수",
	round(avg(basicpay)) AS "부서별 평균급여",
	sum(basicpay) AS "부서별 지급액",
	max(basicpay) AS "부서내의 최고 급여",
	min(basicpay) AS "부서내의 최저 급여"
FROM TBLINSA
	GROUP BY buseo;

SELECT
	count(decode(gender, 'm', 1)) AS "남자수",
	count(decode(gender, 'f', 1)) AS "여자수"
FROM TBLCOMEDIAN;

SELECT
	gender,
	count(*)
FROM TBLCOMEDIAN
	GROUP BY GENDER;

SELECT
	JIKWI,
	count(*)
FROM TBLINSA
	GROUP BY JIKWI;

SELECT
	gender,
	max(HEIGHT),
	min(HEIGHT),
	max(WEIGHT),
	min(WEIGHT),
	avg(WEIGHT),
	avg(HEIGHT)
FROM TBLCOMEDIAN
	GROUP BY gender;

-- ORA-00979: not a GROUP BY expression
-- group by 사용 시 > select 컬럼리스트 > 일반 컬럼 명시 불가능 > 집계 함수 + 그룹컬럼
SELECT
	count(*),
	name
FROM TBLINSA
	GROUP BY BUSEO;

SELECT
	count(*),
	buseo
FROM TBLINSA
	GROUP BY BUSEO;


-- 다중 그룹
SELECT
	buseo,
	JIKWI,
	count(*)
FROM TBLINSA
	GROUP BY buseo, JIKWI
		ORDER BY BUSEO, JIKWI;


	
-- 급여별 그룹
-- 100만원 이하
-- 100만원 ~ 200만원
-- 200만원 이상

SELECT
	basicpay,
	count(*)
FROM TBLINSA
	GROUP BY BASICPAY;

SELECT
	BASICPAY,
	floor(basicpay / 1000000)
FROM TBLINSA;

SELECT
	(floor(basicpay / 1000000) + 1) * 100 || '만원 이하' AS money,
	count(*)
FROM tblinsa
	GROUP BY floor(basicpay / 1000000);

-- tblInsa. 남자/여자 직원수?
SELECT
	substr(ssn, 8, 1),
	count(*)
FROM tblinsa
	GROUP BY substr(ssn, 8, 1);

SELECT 
	count(CASE
		WHEN completedate IS NOT NULL THEN 1
	END),
	count(CASE
		WHEN completedate IS NULL THEN 1
	END)	
FROM TBLTODO;
	 
SELECT
	CASE
		WHEN completedate IS NOT NULL THEN 1
		ELSE 2
	END,
	count(*)
FROM TBLTODO
	GROUP BY CASE
				WHEN completedate IS NOT NULL THEN 1
				ELSE 2
			END;


/*
 	select 컬럼리스트		5. 컬럼 지정
	from 테이블			1. 테이블 지정
	where 조건 			2. 조건 지정(레코드에 대한 조건 - 개인 조건)
	group by 기준			3. (레코드끼리) 그룹을 나눈다.
	having 조건			4. 조건 지정(그룹에 대한 조건 - 그룹 조건 > 집계 함수)
	order by 정렬기준; 	6. 순서대로
	
 */

SELECT
	count(*)
FROM TBLINSA
	WHERE basicpay >= 1500000;



SELECT							--4. 각 그룹별 > 집계 함수					
	buseo,
	round(avg(basicpay))
FROM TBLINSA					--1. 60명의 데이터를 가져온다.
	WHERE basicpay >= 1500000	--2. 60명을 대상으로 조건을 검사한다.
	GROUP BY BUSEO;				--3. 2번을 통과한 사람들(27명) 대상으로 그룹을 짓는다.

SELECT
	buseo,
	round(avg(basicpay))
FROM TBLINSA								--1. 60명
	GROUP BY BUSEO							--2. 60명 > 그룹
		HAVING avg(BASICPAY) >= 1500000;	--3. 집합에 대한 조건 > 집계 함수 조건

-- 부서의 인원수가 10명이 넘는 결과
SELECT
	buseo,
	count(*)
	FROM TBLINSA
	GROUP BY buseo
		HAVING count(*) > 10;

-- 부서의 과장/부장 인원수가 3명이 넘는 결과
SELECT
	buseo,
	count(*)
FROM TBLINSA
	WHERE JIKWI IN ('과장', '부장')
		GROUP BY BUSEO
			HAVING count(*) >= 3;

		
--job_id 그룹 > 통계
SELECT 
	job_id,
	count(*) AS 인원수,
	round(avg(salary)) AS 평균급여
FROM EMPLOYEES
	GROUP BY job_id;


-- 시도별 인원수?
SELECT
	*
FROM TBLADDRESSBOOK;

SELECT
	substr(address, 1, instr(address, ' ') - 1)
FROM TBLADDRESSBOOK;


SELECT
	substr(address, 1, instr(address, ' ') - 1) AS 시도,
	count(*) AS 인원수
FROM TBLADDRESSBOOK
	GROUP BY substr(address, 1, instr(address, ' ') - 1)
		ORDER BY 인원수 desc;


-- 부서별 / 직급별 인원수를 가져오시오.
/*
 
	[부서명]	[총인원]	[부장]	[과장]	[대리]	[사원] 
 	기획부	6		1		1		2		2

 */
	
SELECT
	buseo AS 부서명,
	count(*) AS 총인원,
	count(decode(jikwi, '부장', 1)) AS 부장,
	count(decode(jikwi, '과장', 1)) AS 과장,
	count(decode(jikwi, '대리', 1)) AS 대리,
	count(decode(jikwi, '사원', 1)) AS 사원
FROM TBLINSA
	GROUP BY BUSEO;
	GROUP BY buseo;
	
	
SELECT
	buseo,
	jikwi,
	count(*)
FROM TBLINSA
	GROUP BY buseo, jikwi
		ORDER BY buseo, jikwi;
	
/*
	
	rollup() -- group by에서만 쓸 수 있음
	- group by의 집계 결과를 좀 더 자세하게 반환
	- 그룹별 중간 통계
	
 */

SELECT
	buseo,
	count(*),
	sum(basicpay),
	round(avg(basicpay)),
	max(basicpay),
	min(basicpay)
FROM TBLINSA
	GROUP BY rollup(buseo);
	
	
SELECT
	buseo,
	jikwi,
	count(*),
	sum(basicpay),
	round(avg(basicpay)),
	max(basicpay),
	min(basicpay)
FROM TBLINSA
	GROUP BY rollup(buseo, jikwi);	
	
-- rollup > 다중 그룹 컬럼 > 수직관계(전체인원 총계, 부서별 총계)
-- cube > 다중 그룹 컬럼 > 수평관계(전체인원 총계, 부서별 총계, 직위별 총계)
/*
 
	cube 

 */	
	
SELECT
	buseo,
	count(*),
	sum(basicpay),
	round(avg(basicpay)),
	max(basicpay),
	min(basicpay)
FROM TBLINSA
	GROUP BY cube(buseo);
	
	
SELECT
	buseo,
	jikwi,
	count(*),
	sum(basicpay),
	round(avg(basicpay)),
	max(basicpay),
	min(basicpay)
FROM TBLINSA
	GROUP BY cube(buseo, jikwi);	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	



	


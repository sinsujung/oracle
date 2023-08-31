-- 문제03.sql



-- 집계함수 > count()



-- 1. tblCountry. 아시아(AS)와 유럽(EU)에 속한 나라의 개수?? -> 7개
SELECT
	count(CONTINENT)
FROM TBLCOUNTRY WHERE CONTINENT IN('AS', 'EU');

-- 2. 인구수가 7000 ~ 20000 사이인 나라의 개수?? -> 2개
SELECT
	count(POPULATION)
FROM TBLCOUNTRY WHERE POPULATION > 7000 AND POPULATION < 20000;


-- 3. hr.employees. job_id > 'IT_PROG' 중에서 급여가 5000불이 넘는 직원이 몇명? -> 2명
SELECT
	count(SALARY)
FROM EMPLOYEES
	WHERE JOB_ID = 'IT_PROG' AND salary > 5000;


-- 4. tblInsa. tel. 010을 안쓰는 사람은 몇명?(연락처가 없는 사람은 제외) -> 42명
SELECT
  	count(
  	CASE 
  		WHEN tel NOT in('010') THEN 1
  	END
  	)
FROM TBLINSA;  
    
SELECT
	*
FROM TBLINSA;

-- 5. city. 서울, 경기, 인천 -> 그 외의 지역 인원수? -> 18명
SELECT
	count(
	CASE
		WHEN city NOT in('서울', '경기', '인천') THEN 1
	END
	)
FROM TBLINSA;
    

-- 6. 여름태생(7~9월) + 여자 직원 총 몇명? -> 7명
SELECT
	count(ssn)
FROM TBLINSA
	WHERE ssn LIKE '__07__-2______' OR ssn LIKE '__08__-2______' OR ssn LIKE '__09__-2______';

-- 7. 개발부 + 직위별 인원수? -> 부장 ?명, 과장 ?명, 대리 ?명, 사원 ?명
SELECT
	count(CASE
		WHEN jikwi ='부장' THEN 1
	END) AS 부장수,
	count(CASE
		WHEN jikwi ='과장' THEN 1
	END) AS 과장수,
	count(CASE
		WHEN jikwi ='대리' THEN 1
	END) AS 대리수,
	count(CASE
		WHEN jikwi ='사원' THEN 1
	END) AS 사원수
FROM TBLINSA WHERE BUSEO = '개발부';

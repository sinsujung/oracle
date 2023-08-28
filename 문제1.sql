-- 요구사항.001.tblCountry
-- 모든 행과 모든 컬럼을 가져오시오.
SELECT * FROM TBLCOUNTRY ;

-- 요구사항.002.tblCountry
-- 국가명과 수도명을 가져오시오.
SELECT  name, capital FROM TBLCOUNTRY ;

-- 요구사항.003.tblCountry
-- 아래와 같이 가져오시오
-- [국가명]    [수도명]   [인구수]   [면적]    [대륙] <- 컬럼명
-- 대한민국   서울        4403       101       AS     <- 데이터
SELECT 
	name AS 국가명,
	capital AS 수도명,
	population AS 인구수,
	continent AS 면적,
	area AS 대륙
FROM TBLCOUNTRY ;

--요구사항.004.tblCountry
--아래와 같이 가져오시오
-- [국가정보] <- 컬럼명
-- 국가명: 대한민국, 수도명: 서울, 인구수: 4403   <- 데이터
SELECT name AS 국가명, capital AS 수도명, population AS 인구수 FROM TBLCOUNTRY 국가정보;

--요구사항.005
--아래와 같이 가져오시오.employees
-- [이름]                 [이메일]                 [연락처]            [급여]
-- Steven King	        SKING@gmail.com	515.123.4567	   $24000
SELECT * FROM EMPLOYEES ;
SELECT 
	first_name|| ' ' || last_name AS 이름,
	email || '@gmail.com' AS 이메일,
	PHONE_NUMBER AS 연락처,
	'$' || SALARY AS 급여
FROM EMPLOYEES ;

--요구사항.006.tblCountry
--면적(area)이 100이하인 국가의 이름과 면적을 가져오시오.
SELECT * FROM TBLCOUNTRY WHERE AREA <= 100;

--요구사항.007.tblCountry
--아시아와 유럽 대륙에 속한 나라를 가져오시오.
SELECT * FROM TBLCOUNTRY WHERE CONTINENT = 'AS' OR CONTINENT = 'EU';

--요구사항.008.employees
--직업(job_id)이 프로그래머(it_prog)인 직원의 이름(풀네임)과 연락처 가져오시오.
SELECT FIRST_NAME || ' ' || LAST_NAME, PHONE_NUMBER FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';

--요구사항.009.employees
--last_name이 'Grant'인 직원의 이름, 연락처, 고용날짜를 가져오시오.
SELECT * FROM EMPLOYEES ;
SELECT first_name || ' ' || last_name AS 이름, phone_number AS 연락처, hire_date AS 고용날짜 FROM EMPLOYEES WHERE LAST_NAME = 'Grant';


--요구사항.010.employees
--특정 매니저(manager_id: 120)이 관리하는 직원의 이름, 급여, 연락처를 가져오시오.
SELECT  first_name || ' ' || last_name AS 이름, salary AS 급여, phone_number AS 연락처 FROM EMPLOYEES WHERE MANAGER_ID = 120;


--요구사항.011.employees
--특정 부서(60, 80, 100)에 속한 직원들의 이름, 연락처, 이메일, 부서ID 가져오시오.
--SELECT first_name || ' ' || last_name AS 이름, phone_number AS 연락처, email || '@gmail.com' AS 이메일, employee_id AS 부서ID FROM EMPLOYEES WHERE DEPARTMENT_ID = 60 OR DEPARTMENT_ID = 80 OF DEPARTMENT_ID = 100;

--요구사항.012.tblInsa
--기획부 직원들 가져오시오.
SELECT * FROM TBLINSA ;
SELECT * FROM TBLINSA WHERE BUSEO = '기획부';

--요구사항.013.tblInsa
--서울에 있는 직원들 중 직위가 부장인 사람의 이름, 직위, 전화번호 가져오시오.
SELECT name, jikwi, tel FROM TBLINSA WHERE CITY = '서울' AND JIKWI = '부장';


--요구사항.014.tblInsa
--기본급여 + 수당 합쳐서 150만원 이상인 직원 중 서울에 직원만 가져오시오.
SELECT * FROM TBLINSA WHERE BASICPAY + SUDANG >= 150 AND CITY = '서울';


--요구사항.015.tblInsa
--수당이 15만원 이하인 직원 중 직위가 사원, 대리만 가져오시오.
SELECT * FROM TBLINSA WHERE SUDANG <=15 AND JIKWI ='사원' OR JIKWI ='대리';



--요구사항.016.tblInsa
--수당을 제외한 기본 연봉이 2천만원 이상, 서울, 직위 과장(부장)만 가져오시오.
SELECT * FROM TBLINSA WHERE BASICPAY * 12 - SUDANG = 20000000 AND CITY ='서울' AND JIKWI = '과장' OR JIKWI ='부장';



--요구사항.017.tblCountry
--국가명 'O국'인 나라를 가져오시오.
SELECT *FROM TBLCOUNTRY ;
SELECT * FROM TBLCOUNTRY WHERE NAME LIKE '_국';


--요구사항.018.employees
--연락처가 515로 시작하는 직원들 가져오시오.
SELECT * FROM EMPLOYEES ;
SELECT * FROM EMPLOYEES WHERE PHONE_NUMBER LIKE '515%';

    

--요구사항.019.employees
--직업 ID가 SA로 시작하는 직원들 가져오시오.


    

--요구사항.020.employees
--first_name에 'de'가 들어간 직원들 가져오시오.



--요구사항.021.tblInsa
--남자 직원만 가져오시오.



-- 요구사항.022.tblInsa
--여자 직원만 가져오시오.   



--요구사항.023.tblInsa
--여름에(7,8,9월) 태어난 직원들 가져오시오.



--요구사항.024.tblInsa
--서울, 인천에 사는 김씨만 가져오시오.    



--요구사항.025.tblInsa
--영업부/총무부/개발부 직원 중 사원급(사원/대리) 중에 010을 사용하는 직원들을 가져오시오.




--요구사항.026.tblInsa
--서울/인천/경기에 살고 입사일이 2008~2010년 사이인 직원들을 가져오시오.



--요구사항.027.employees
--부서가 아직 배정 안된 직원들을 가져오시오. (department_id가 없는 직원)










-- 요구사항.001.tblCountry > 14행

-- 요구사항.002.tblCountry > 14행

-- 요구사항.003.tblCountry > 14행

--요구사항.004.tblCountry > 14행

--요구사항.005 > 107행

--요구사항.006.tblCountry > 9행

--요구사항.007.tblCountry > 7행

--요구사항.008.employees > 5행

--요구사항.009.employees > 2행

--요구사항.010.employees > 8행

--요구사항.011.employees > 45행

--요구사항.012.tblInsa > 7행

--요구사항.013.tblInsa > 3행

--요구사항.014.tblInsa > 9행

--요구사항.015.tblInsa > 28행

--요구사항.016.tblInsa > 6행

--요구사항.017.tblInsa > 3행

--요구사항.018.employees > 21행

--요구사항.019.employees > 35행

--요구사항.020.employees > 2행

--요구사항.021.tblInsa > 31행

-- 요구사항.022.tblInsa > 29행

--요구사항.023.tblInsa > 14행

--요구사항.024.tblInsa > 8행

--요구사항.025.tblInsa > 10행

--요구사항.026.tblInsa > 18행

--요구사항.027.employees > 1행
--ex12_datetime_function.sql

/*
	
	날짜 시간 함수
	
	sysdate
	- 현재 시스템의 시각을 반환
	- calendar.getInstance()
	- date  sysdate
	
	
 */
SELECT sysdate FROM dual;


/*
 	
 	날자 연산
 	1. 시각 - 시각 = 시간
 	2. 시각 + 시간 = 시각
 	3. 시각 - 시간 = 시각
 		
 */

-- 1. 시각 - 시각 = 시간(일)
SELECT
	name,
	ibsadate,
	round(sysdate - IBSADATE) AS 근무일수,--1998-10-11 9088.6 > 이 숫자의 단위는 뭘까요~(일)
	round((sysdate -IBSADATE)/ 365) AS 근무년수, --윤년 계산이 따로 안됌 > 사용금지
	round((sysdate -IBSADATE) * 24) AS 근무시수,
	round((sysdate -IBSADATE) * 24 * 60) AS 근무분수,
	round((sysdate -IBSADATE) * 24 * 60 * 60) AS 근무초수
FROM TBLINSA;

--오라클 > 식별자 최대 길이 > 30바이트(UTF-8)
--ORA-00900: invalid SQL statement > 식별자가 너무 길어요~
SELECT
	title,
	adddate,
	completedate,
	round((completedate - adddate)* 24) AS 실행하기까지걸린시간
FROM TBLTODO
	WHERE completedate IS NOT NULL
	ORDER BY round((completedate - adddate) * 24) desc;


-- 2. 시각 + 시간(일) = 시각
-- 3. 시각 - 시간(일) = 시각
SELECT
	sysdate,
	sysdate + 100 AS "100일뒤",
	sysdate - 100 AS "100일전",
	sysdate + (3 / 24) AS "3시간 후",
	sysdate - (5 / 24) AS "5시간 전",
	sysdate + (30 / 60 / 24) AS "30분 뒤"
FROM dual;


/*
	
	시각 - 시각 = 시간(일) > 일 > 시 > 분 > 초 환산 가능
					  > 일 > 월 > 년 환산 불가능 // 한달이 며칠인지 알 수 없어서
					  
	시각 + 시간 (일) = 시각 > 일, 시, 분, 초 가능
						> 월, 년 불가능
	
	
 */
SELECT sysdate + 3개월 FROM dual;

/*
 
 	months_between()
 	- number months_between(date, date)
 	- 시각 - 시각 = 시간(월)
 	
 */
SELECT
	name,
	round(sysdate - ibsadate) AS "근무일수",
	round((sysdate - ibsadate) / 30) AS "근무월수",
	round(MONTHS_BETWEEN(sysdate, IBSADATE)) AS "근무월수",
	round(MONTHS_BETWEEN(sysdate, IBSADATE) / 12) AS "근무년수"
FROM TBLINSA;

/*
 
 	add_months()
 	- date add_months(date, 시간)
 	- 시각 + 시간(월) = 시각
 
 */

SELECT
	sysdate,
	add_months(sysdate, 3),
	add_months(sysdate, -2),
	add_months(sysdate, 5 * 12)
FROM dual;

/*
 	
	시각 - 시각
	1. 일, 시, 분, 초 > 연산자(-)
	2. 월, 년 > months_between()
	
	시각 +- 시간
	1. 일, 시, 분, 초 > 연산자(+,-)
	2. 월, 년 > add_months()
	
 */

SELECT
	sysdate,
	last_day(sysdate) -- 해당 날짜 포함된 마지막 날짜 반환(해당 월이 며칠까지 있는지 구할 때 쓰는 용도)
FROM dual;























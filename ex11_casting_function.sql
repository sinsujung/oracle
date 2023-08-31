--ex11_casting_function.sql

/*

	형변환 함수
	-(int)num
	
	1. to_char(숫자)		: 숫자 > 문자
	2. to_char(날짜)		: 날짜 > 문자 ***
	3. to_number(문자)	: 문자 > 숫자
	4. to_date(문자)		: 문자 > 날짜 ***
	
	1. to_char(숫자[, 형식문자열])
	
	형식 문자열 구성요소
	a. 9: 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리를 스페이스로 치환.	> %5d 
	b. 0: 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리를 0으로 치환. 	> %05d
	c. $: 통화 기호 표현
	d. L: 통화 기호 표현(Locale)
	e. .: 소숫점
	f. ,: 천단위 표기
	
	
	
*/
SELECT
	WEIGHT,
	TO_CHAR(WEIGHT),
	LENGTH(to_char(WEIGHT)),-- 문자열 함수 --숫자는 우측 정렬, 문자는 좌측 정렬
	length(WEIGHT), -- weight > (암시적 형변환) > 문자열
	substr(WEIGHT, 1, 1),
	weight || 'kg',
	to_char(weight) || 'kg' -- 원래는 이렇게 해야 정상
FROM TBLCOMEDIAN;

SELECT
	weight,
	'@' || to_char(WEIGHT) || '@',
	'@' || to_char(WEIGHT,'99999') || '@', --@    64@//맨앞 한자리는 부호자리 +는 눈에 안보이고 -는 보임
	'@' || to_char(-WEIGHT,'99999') || '@', --@   -64@
	'@' || to_char(WEIGHT,'00000') || '@',
	'@' || to_char(-WEIGHT,'00000') || '@'
FROM TBLCOMEDIAN;


SELECT
	100,
	'$' || 100,
	to_char(100, '$999'),
	--to_char(100, '999달러')
	100 || '달러',
	to_char(100, 'L999')
FROM dual;


SELECT
	1234567.89,
	to_char(1234567.89, '9,999,999.9'), --%,d
	ltrim(to_char(567.89, '9,999,999.9')),
	to_char(2341234567.89, '9,999,999.9')
FROM dual;


/*
 	2. to_char(날짜)
 	- 날짜 > 문자
 	- char to_char(컬럼, 형식문자열)
 	
 	형식문자열 구성요소
 	a. yyyy
 	b. yy
 	c. month
 	d. mon
 	e. mm
 	f. day
 	g. dy
 	h. ddd
 	i. dd
 	j. d
 	k. hh
 	l. hh24
 	m. mi
 	n. ss
 	o. am(pm)
 */

SELECT SYSDATE FROM dual;
SELECT to_char(SYSDATE) FROM dual; --X
SELECT to_char(SYSDATE, 'yyyy') FROM dual;	--년(4자리)
SELECT to_char(SYSDATE, 'yy') FROM dual;	--년(2자리)
SELECT to_char(SYSDATE, 'month') FROM dual;	--월(풀네임)
SELECT to_char(SYSDATE, 'mon') FROM dual;	--월(약어)
SELECT to_char(SYSDATE, 'mm') FROM dual;	--월(2자리)
SELECT to_char(SYSDATE, 'day') FROM dual;	--요일(풀네임)
SELECT to_char(SYSDATE, 'dy') FROM dual;	--요일(약어)
SELECT to_char(SYSDATE, 'ddd') FROM dual;	--일(올해의 며칠)
SELECT to_char(SYSDATE, 'dd') FROM dual;	--일(이번달의 며칠)
SELECT to_char(SYSDATE, 'd') FROM dual;		--일(이번주의 며칠) == 요일의 숫자버전
SELECT to_char(SYSDATE, 'hh') FROM dual;	--시(12시 체계)
SELECT to_char(SYSDATE, 'hh24') FROM dual;	--시(24시 체계)
SELECT to_char(SYSDATE, 'mi') FROM dual;	--분
SELECT to_char(SYSDATE, 'ss') FROM dual;	--초
SELECT to_char(SYSDATE, 'am') FROM dual;	--오전/오후
SELECT to_char(SYSDATE, 'pm') FROM dual;	--오전/오후

--암기!!
SELECT
	sysdate,
	to_char(sysdate, 'yyyy-mm-dd'),
	to_char(sysdate, 'hh24:mi:ss'),
	to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
	to_char(sysdate, 'day am hh:mi:ss')
FROM dual;


SELECT
	name,
	to_char(ibsadate, 'yyyy-mm-dd') AS IBSADATE,
	to_char(IBSADATE, 'day') AS DAY,
	CASE
		WHEN to_char(IBSADATE, 'd') IN ('1', '7') THEN '휴일입사'
		ELSE '평일입사'
	END
FROM TBLINSA;


-- 요일별 입사 인원수?
SELECT
	count(CASE
		WHEN to_char(IBSADATE, 'd') = '1' THEN 1 
	END) AS 일요일,
	count(decode(TO_CHAR(ibsadate, 'd'), '2', 1)) AS 월요일,
	count(decode(TO_CHAR(ibsadate, 'd'), '3', 1)) AS 화요일,
	count(decode(TO_CHAR(ibsadate, 'd'), '4', 1)) AS 수요일,
	count(decode(TO_CHAR(ibsadate, 'd'), '5', 1)) AS 목요일,
	count(decode(TO_CHAR(ibsadate, 'd'), '6', 1)) AS 금요일,
	count(decode(TO_CHAR(ibsadate, 'd'), '7', 1)) AS 토요일
FROM TBLINSA;


--SQL에는 날자 상수(리터럴)이 없다.

--입사날짜 > 2000년 이후
SELECT
	*
FROM TBLINSA
	WHERE IBSADATE >= '2000-01-01'; --문자열 > 암시적 형변환

-- 입사날짜 > 2000년 ~ 2001년 사이
	
SELECT * FROM TBLINSA
	WHERE IBSADATE >= '2000-01-01' AND IBSADATE <= '2000-12-31'; --오답

SELECT * FROM TBLINSA
	WHERE IBSADATE >= '2000-01-01 00:00:00' AND IBSADATE <= '2000-12-31 23:59:59';


SELECT * FROM TBLINSA
	WHERE to_char(IBSADATE, 'yyyy') = '2000';




-- 3. number to_number(문자)

SELECT
	'123' * 2, --암시적 형변환
	to_number('123') * 2
FROM dual;


--4. date to_date(문자, 형식문자열)

SELECT
	'2023-08-29', --자료형? 문자 vs 날짜
	to_date('2023-08-29'),
	to_date('2023-08-29', 'yyyy-mm-dd'),
	to_date('20230829'),
	to_date('20230829','yyyymmdd'),
	to_date('2023/08/29'),
	to_date('2023/08/29', 'yyyy/mm/dd'),
	--to_date('2023년08월29일', '2023년mm월dd일')
	to_date('2023-08-29 15:28:39','yyyy-mm-dd hh24:mi:ss')
FROM dual;

SELECT * FROM TBLINSA
	WHERE IBSADATE >= to_date('2000-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss')
		AND IBSADATE <= to_date('2000-12-31 23:59:59', 'yyyy-mm-dd hh24:mi:ss');




































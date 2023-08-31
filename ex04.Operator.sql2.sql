--ex04.Operator

/*
    연산자, Operator
    
    
    
    1. 산술 연산자
    - +,-,*,/
    - %(없음) > 함수로 제공(mod())
    
    2. 문자열 연산자(concat)
    - +(X) > ||(O)
    
    3. 비교 연산자
    - >, >=, <, <=
    - =(==), <>(!=)
    - 논리값 반환 > SQL에는 boolean이 없다. > 명시적으로 표현 불가능 > 조건이 필요한 상황에서 내부적으로 사용
    - 컬럼 리스트에서 사용 불가
    - 조건절에서 사용
    
    4. 논리 연산자
    - and(&&), or(||), not(!)
    - 논리값 반환
    - 컬럼 리스트에서 사용 불가
    - 조건절에서 사용
    
    5. 대입 연산자
    - =
    - 컬럼 = 값
    - update문
    
    6. 3항 연산자
    - 없음
    - 제어문 없음

    7. 증감 연산자
    - 없음
    
    8. SQL 연산자
    - 자바 연산자 > instanceof, typeof 등..
    - in, between, like, is 등..(00절, 00구..)
    
    
            
*/
-- 4405 10 4415

SELECT * FROM TBLTODO t ;

INSERT INTO TBLTODO (seq, title, adddate, completedate)
	VALUES (24, 'CSS HTML 복습하기', sysdate, null);
	
COMMIT;

SELECT * FROM TBLADDRESSBOOK ;

select population, area,
    population + area,
    population - area,
    population * area,
    population / area
    
from tblCountry;

--ORA-01722: invalid number
--SELECT name, couple, name + couple FROM TBLMEN ;
SELECT name, couple, name || couple FROM TBLMEN ;

SELECT HEIGHT, WEIGHT, HEIGHT > WEIGHT FROM TBLMEN ; -- 비교연산자는 컬럼리스트에서 사용할 수 없다.

SELECT height, weight FROM tblmen WHERE height> weight;



SELECT name, age FROM tblMen; -- 이전 나이(한국식)



--컬럼의 별칭(Alias)
-- : 되도록이면 가공된 컬럼에만 적용
-- : 함수 결과에 적용
-- : *** 컬럼명이 식별자로 적합하지 않을 때 사용 > 적합한 식별자로 수정
-- 공백은 식별자로 들어갈 수 없음. 만약 공백을 반드시 넣어야하는 상황이면 쌍따옴표로 묶으면 됌.(억지 부리는 거니까 쓰지 않길 권장)

SELECT
	name AS 이름, 
	age, 
	age-1 AS 나이, 
	LENGTH(name) AS 길이,
	couple AS 여자친구,
	name "select"
FROM tblMen; --컬럼명(***)

--테이블 별칭(Alias)
-- : 편하게 .. + 가독성 향상
SELECT * FROM tblMen t;

SELECT hr.tblMen.name, hr.tblMen.age, hr.tblMen.height, hr.tblMen.weight, 
hr.tblMen.couple FROM hr.tblMen;-- 정석 (테이블 이름 앞에 소유주 이름이 들어가야함) > 가독성이 너무 떨어짐

-- 각 절의 실행 순서
-- 2. select 절
-- 1. from 절

SELECT m.name, m.age, m.height, m.weight, m.couple 
FROM tblMen m; --너무 지저분해서 별칭을 붙이는 것/ 그래서 보통은 한글자에서 세글자 이내로 붙인다.



















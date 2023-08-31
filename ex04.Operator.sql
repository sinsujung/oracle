--ex04.Operator

/*
    연산자, Operator
    
    
    
    1. 산술 연산자
    - +,-,*,/
    - %(없음) > 함수로 제공(mod())
*/
-- 4405 10 4415
select population, area,
    population + area,
    population - area,
    population * area,
    population / area
    
from tblCountry;

select population, area, population + area from tblCountry;


SELECT * FROM TBLTODO t ;

INSERT INTO TBLTODO (seq, title, adddate, completedate)
	VALUES (22, '자바 복습하기', sysdate, null);

commit;
















--1. traffic_accident. 각 교통 수단 별(지하철, 철도, 항공기, 선박, 자동차) 발생한 총 교통 사고 발생 수, 총 사망자 수, 사건 당 평균 사망자 수를 가져오시오.
SELECT
	trans_type,
    sum(total_acct_num) as 총교통사고발생수,
    sum(death_person_num) as 총사망자수,
   round(avg(death_person_num)) as 평균사망자수
FROM TRAFFIC_ACCIDENT
        group by trans_type;

select * from traffic_accident;

        
        

--2. tblZoo. 종류(family)별 평균 다리의 갯수를 가져오시오.

SELECT
	*
FROM tblzoo;

select
    family,
    round(avg(leg)) as 평균다리갯수
from tblzoo
        group by family;

SELECT
	family AS 종류,
	round(avg(leg)) AS "평균 다리수"
FROM tblZoo 
	GROUP BY family;
    

    
--3. tblZoo. 체온이 변온인 종류 중 아가미 호흡과 폐 호흡을 하는 종들의 갯수를 가져오시오.
SELECT
	*
FROM tblzoo;

SELECT
	family AS 종류,
	count(breath)
FROM tblzoo 
	WHERE thermo = 'variable'
		GROUP BY family;
        
        

--4. tblZoo. 사이즈와 종류별로 그룹을 나누고 각 그룹의 갯수를 가져오시오.

SELECT
	*
FROM tblzoo;

SELECT
	family AS 종류별,
	sizeof AS 사이즈별,
	count(*) AS 갯수
FROM tblzoo 
	GROUP BY sizeof, family
		ORDER BY family;
        


        
        

--12. tblAddressBook. 관리자의 실수로 몇몇 사람들의 이메일 주소가 중복되었다. 중복된 이메일 주소만 가져오시오.

SELECT
	*
FROM tbladdressbook ;
    
SELECT
	email
FROM tbladdressbook 
	GROUP BY email
		HAVING count(email) > 1;


            

--15. tblAddressBook. 성씨별 인원수가 100명 이상 되는 성씨들을 가져오시오.
SELECT
	*
FROM tbladdressbook ;

SELECT
	DISTINCT(substr(name,1,1))
FROM tbladdressbook
	GROUP BY NAME
		HAVING count(substr(name,1,1)) >= 100;



            
            

--17. tblAddressBook. 이메일이 스네이크 명명법으로 만들어진 사람들 중에서 여자이며, 20대이며, 키가 150~160cm 사이며, 고향이 서울 또는 인천인 사람들만 가져오시오.

select
    name
from tbladdressbook
    where gender = 'f'
        and age between 20 and 30
        and height between 150 and 160
        and hometown = '서울' 
        or hometown = '인천'
        group by name;



--20. tblAddressBook. '건물주'와 '건물주자제분'들의 거주지가 서울과 지방의 비율이 어떻게 되느냐?
select * from tbladdressbook;

SELECT
     job,
    round(SUM(CASE WHEN hometown = '서울' THEN 1 ELSE 0 END) / COUNT(*) * 100) AS 서울,
    round(SUM(CASE WHEN hometown != '서울' THEN 1 ELSE 0 END) / COUNT(*) * 100) AS 지방
FROM
    tblAddressBook
WHERE
    job IN ('건물주', '건물주자제분')
    GROUP BY
        job;





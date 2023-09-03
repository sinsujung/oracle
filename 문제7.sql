--16. tblAddressBook. 남자 평균 나이보다 나이가 많은 서울 태생 + 직업을 가지고 있는 사람들을 가져오시오.

select
    *
from tbladdressbook;

SELECT 
    name,
    hometown,
    job,
    age
FROM TBLADDRESSBOOK
    WHERE
        age > (SELECT AVG(age) FROM TBLADDRESSBOOK where gender = 'm')
        and hometown = '서울'
        and job not in ('학생', '취업준비생');

-- employees. 'Munich' 도시에 위치한 부서에 소속된 직원들 명단?
select
    *
from employees;

-- tblMan. tblWoman. 서로 짝이 있는 사람 중 남자와 여자의 정보를 모두 가져오시오.
--    [남자]        [남자키]   [남자몸무게]     [여자]    [여자키]   [여자몸무게]
--    홍길동         180       70              장도연     177        65
--    아무개         175       null            이세영     163        null
--    ..
select
    m.name as 남자,
    m.height as 남자키,
    m.weight as 남자몸무게,
    w.name as 여자,
    w.height as 여자키,
    w.weight as 여자몸무게
from tblMen m
    inner join tblwomen w
        on m.couple = w.name;



    
    

-- tblAddressBook. 가장 많은 사람들이 가지고 있는 직업은 주로 어느 지역 태생(hometown)인가?

select
    *
from tbladdressbook;

SELECT
    job AS 가장많은직업,
    hometown AS 직업을가진사람의태생,
    COUNT(*) AS 인원수
FROM tblAddressBook
GROUP BY job, hometown
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM tblAddressBook
        GROUP BY job, hometown
    )
);

-- tblAddressBook. 이메일 도메인들 중 평균 아이디 길이가 가장 긴 이메일 사이트의 도메인은 무엇인가?


select
    *
from tbladdressbook;

SELECT
    SUBSTR(email, INSTR(email, '@') + 1) AS domain,
    AVG(LENGTH(SUBSTR(email, 1, INSTR(email, '@') - 1))) AS avg_id_length
FROM tblAddressBook
GROUP BY SUBSTR(email, INSTR(email, '@') + 1)
ORDER BY AVG(LENGTH(SUBSTR(email, 1, INSTR(email, '@') - 1))) DESC;



            
            

-- tblAddressBook. 평균 나이가 가장 많은 출신(hometown)들이 가지고 있는 직업 중 가장 많은 직업은?
select
    *
from tbladdressbook;

SELECT 
    job,
    COUNT(*) AS job_count
    FROM tblAddressBook
        WHERE hometown IN (
    SELECT hometown
        FROM tblAddressBook
            GROUP BY hometown
                HAVING AVG(age) = (
        SELECT MAX(AVG(age))
            FROM tblAddressBook
                GROUP BY hometown
    )
)
GROUP BY job
ORDER BY job_count DESC;

-- tblAddressBook. 남자 평균 나이보다 나이가 많은 서울 태생 + 직업을 가지고 있는 사람들을 가져오시오.

    SELECT 
    name,
    hometown,
    job,
    age
FROM TBLADDRESSBOOK
    WHERE
        age > (SELECT AVG(age) FROM TBLADDRESSBOOK where gender = 'm')
        and hometown = '서울'
        and job not in ('학생', '취업준비생');


-- tblAddressBook. 가장 나이가 많으면서 가장 몸무게가 많이 나가는 사람과 같은 직업을 가지는 사람들을 가져오시오.

select
    a. name,
    a. age,
    a. weight,
    a. job
from tbladdressbook a
    where a.job = (select job from tbladdressbook where age = (select max(age) 
    FROM tblAddressBook) 
    AND weight = (SELECT MAX(weight) FROM tblAddressBook));

-- tblAddressBook.  동명이인이 여러명 있습니다. 이 중 가장 인원수가 많은 동명이인(모든 이도윤)의 명단을 가져오시오.
SELECT 
    name,
    age,
    weight,
    height,
    tel
FROM tblAddressBook
WHERE name IN (
    SELECT name
    FROM tblAddressBook
    GROUP BY name
    HAVING COUNT(*) = (
        SELECT MAX(name_count)
        FROM (
            SELECT COUNT(*) AS name_count
            FROM tblAddressBook
            GROUP BY name
        )
    )
);



-- tblAddressBook. 가장 사람이 많은 직업의(332명) 세대별 비율을 구하시오.
--    [10대]       [20대]       [30대]       [40대]
--    8.7%        30.7%        28.3%        32.2%
SELECT
    '10대' AS 세대,
    ROUND(COUNT(CASE WHEN age BETWEEN 10 AND 19 THEN 1 END) / COUNT(*) * 100, 1) AS 비율
FROM tblAddressBook
UNION
SELECT
    '20대' AS 세대,
    ROUND(COUNT(CASE WHEN age BETWEEN 20 AND 29 THEN 1 END) / COUNT(*) * 100, 1) AS 비율
FROM tblAddressBook
UNION
SELECT
    '30대' AS 세대,
    ROUND(COUNT(CASE WHEN age BETWEEN 30 AND 39 THEN 1 END) / COUNT(*) * 100, 1) AS 비율
FROM tblAddressBook
UNION
SELECT
    '40대' AS 세대,
    ROUND(COUNT(CASE WHEN age BETWEEN 40 AND 49 THEN 1 END) / COUNT(*) * 100, 1) AS 비율
FROM tblAddressBook;










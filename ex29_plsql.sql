--ex29_plsql.sql

/*

    PL/SQL
    - Oracle's Procedural Language extension to SQL
    - 기존의 ANSI-SQL + 절차 지향 언어 기능 추가
    - ANSI-SQL + 확장팩(변수, 제어 흐름(제어문), 객체(메서드) 정의)
    
    
    프로시저, Procedure
    - 메서드, 함수 등..
    - 순서가 있는 명령어의 집합
    - 모든 PL/SQL 구문은 프로시저내에서만 작성/동작이 가능하다.
    - 프로시저 아닌 영역 > ANSI-SQL 영역
    
    
    1. 익명 프로시저
        - 1회용 코드 작성용
    
    2. 실명 프로시저
        - 데이터베이스 객체
        - 저장용
        - 재호출
    
    PL/SQL 프로시저 구조
    
    1. 4개의 블럭(키워드)으로 구성
        - DECLARE
        - BEGIN
        - EXCEPTION
        - END
        
    
    2. DECLATE
        - 선언부
        - 프로시저내에서 사용할 변수, 객체 등을 선언하는 영역
        - 생략 가능
        
    3. BEGIN ~ END
        - 실행부, 구현부
        - 구현된 코드를 가지는 영역(메서드의 body 영역)
        - 생략 불가능
        - 구현된 코드 > ANSI-SQL + PL/SQL(연산, 제어 등)

    4. EXCEPTION
        - 예외처리부
        - catch 역할, (3번 영역이 try 역할)
        - 생략 가능
        


    자료형 + 변수
    
    PL/SQL 자료형
    - ANSI-SQL과 동일


    변수 선언하기
    - 변수명 자료형 [not null] [default 값];
    
    PL/SQL 연산자
    - ANSI-SQL과 동일
    
    대입 연산자
    - ANSI-SQL 대입 연산자
        ex) update table set column = '값';
    - PL/SQL 대입 연산자
        ex) 변수 := '값';    
    
  
*/


-- 익명 프로시저
set serveroutput on;
set serveroutput off;
declare
    num number;
    name varchar2(30);
    today date;
begin

    num := 10;
    dbms_output.put_line(num); --  java의 syso와 동일

    name := '홍길동';
    dbms_output.put_line(name);

    today := sysdate;
    dbms_output.put_line(today);
    
  
   
end;
/
----------
--옵션을 건드려야 syso 됌
--set serveroutput on; -- 현재 세션에서만 유효(접속 해제 > 초기화;;)
------------

declare
    num1 number;
    num2 number;
    num3 number := 30;
    num4 number default 40;
    num5 number not null := 50; -- declare 블럭에서 초기화를 해야한다.
begin

    dbms_output.put_line(num1); --null

    num2 := 20;
    dbms_output.put_line(num2);

    dbms_output.put_line(num3);
    
    dbms_output.put_line(num4);

    dbms_output.put_line(num5);
    
    

end;
/



/*
 변수 > 어떤 용도로 사용?
    - select 결과를 담는용도(***********************)
    - select into 절(PL/SQL)

*/

declare
    vbuseo varchar2(15);
begin

    select buseo into vbuseo from tblinsa where name = '홍길동';
    dbms_output.put_line(vbuseo);
    
--    select buseo from tblinsa where name = '홍길동';
--    dbms_output.put_line(buseo);  
    
end;
/

begin
    --PL/SQL 프로시저안에서는 순수한 select문은 올 수 없다. (절대)
    --PL/SQL 프로시저안에서느 select into문만 사용한다.
    select buseo from tblinsa where name = '홍길동';
end;


-- 성과급 받는 직원명
create table tblName (
    name varchar2(15)
);

--1. 개발부 + 부장 > select > name?
--2. tblName > name > insert

insert into tblname(name) values ((select name from tblinsa where buseo = '개발부' and jikwi = '부장'));



declare
    vname varchar2(15);
begin

    --1.
    select name into vname from tblinsa where buseo = '개발부' and jikwi = '부장';

    --2.
    insert into tblName (name) values(vname);
end;

select * from tblName;

declare
    vname varchar2(15);
    vbuseo varchar2(15);
    vjikwi varchar2(15);
    vbasicpay number;
begin
    
    --select into
    --select name into vname, buseo into vbuseo, jikwi into vjikwi, basicpay into vbasicpay
    
    -- into 사용시
    --1. 컬럼의 개수와 변수의 개수 일치
    --2. 컬럼의 순서와 변수의 순서 일치
    --3. 컬럼과 변수의 자료형 일치
    select name, buseo, jikwi, basicpay into vname, vbuseo, vjikwi, vbasicpay
        from tblinsa where num = 1001;
        
        dbms_output.put_line(vname);
        dbms_output.put_line(vbuseo);
        dbms_output.put_line(vjikwi);
        dbms_output.put_line(vbasicpay);
end;

desc tblinsa;


/*

    타입 참조
    %type
    - 사용하는 테이블의 특정 컬럼값의 스키마를 알아내서 변수에 적용
    - 복사되는 정보
        a. 자료형
        b. 길이
    - 컬럼 1개 참조
    
    %rowtype
    - 행 전체 참조(여러개의 컬럼을 한번에 참조)
    - %type의 집합형
    - 레코드 전체(여러개의 컬럼)을 하나의 변수에 저장 가능
*/

declare
    --vbuseo varchar2(15);
    vbuseo tblinsa.buseo%type;
begin
    select buseo into vbuseo from tblinsa where name = '홍길동';
    dbms_output.put_line(vbuseo);
end;
---------------------

declare
    vname tblinsa.name%type;
    vbuseo tblinsa.buseo%type;
    vjikwi tblinsa.jikwi%type;
    vbasicpay tblinsa.basicpay%type;
begin
    
    select name, buseo, jikwi, basicpay into vname, vbuseo, vjikwi, vbasicpay
        from tblinsa where num = 1001;
        
        dbms_output.put_line(vname);
        dbms_output.put_line(vbuseo);
        dbms_output.put_line(vjikwi);
        dbms_output.put_line(vbasicpay);
end;


-- 직원 중 일부에게 보너스 지급(급여 * 1.5) > 내역 저장
create table tblbonus (
    seq number primary key,
    num number(5) not null references tblinsa(num), --직원번호(FK)
    bonus number not null
);

declare
    vnum tblinsa.num%type;
    vbasicpay tblinsa.basicpay%type;
begin

    select num, basicpay into vnum, vbasicpay
        from tblinsa where city = '서울' and jikwi = '부장' and buseo = '영업부';
    
    insert into tblBonus (seq, num, bonus)
        values((select nvl(max(seq), 0) + 1 from tblbonus), vnum, vbasicpay * 1.5);
end;

select * from tblbonus;

select 
    * 
from tblbonus b
    inner join tblinsa i
        on i.num = b.num;

select * from tblmen;
select * from tblwomen;

-- 무명씨 > 성전환 수술 > tblMen -> tblWomen 옮기기
-- 1. '무명씨' > tblMen > select 정보 확인
-- 2. tblWomen > insert
-- 3. tblMen > delete
-- 4. 남자 테이블의 무명씨의 정보를 변수에 저장해서 인서트를 이용해서 여자테이브ㅏㄹ에 저장, 이후 남자테이블에서 제거

declare
    vname tblmen.name%type;
    vage tblmen.age%type;
    vheight tblmen.height%type;
    vweight tblmen.weight%type;
    vcouple tblmen.couple%type;
begin
    select name,
            age,
            height,
            weight,
            couple
                into vname, vage, vheight, vweight, vcouple
    from tblmen;
    insert into tblwomen (name, age, height, weight)
        values(vname, vage, vheight, vweight);
end;

declare
--    vname tblmen.name%type;
--    vage tblmen.age%type;
--    vheight tblmen.height%type;
--    vweight tblmen.weight%type;
--    vcouple tblmen.couple%type;

    vrow tblmen*rowtype; --vrow : tblmen의 레코드 1개(모든 컬럼값)를 저장할 수 있는 변수
    
begin
    
    --1.
    select name, age, height, weight, couple
    into
    vname, vage, vheight, vweight, vcouple
    from tblMen where name = '무명씨';
    
    --2.
    insert into tblwomen (name, age, height, weight, couple)
        values(vname, vage, vheight, vweight, vcouple);
        
    --3. 
    delete from tblmen where name =  vname;
    
end;

select * from tblwomen;

-----------------------------------
declare

    vrow tblmen%rowtype; --vrow : tblmen의 레코드 1개(모든 컬럼값)를 저장할 수 있는 변수
    
begin
    
    --1.
    select
        * INTO VROW
    from tblmen where name = '정형돈';
    
    dbms_output.put_line(vrow.name);
    dbms_output.put_line(vrow.age);
    dbms_output.put_line(vrow.height);
    dbms_output.put_line(vrow.weight);
    dbms_output.put_line(vrow.couple);
     
    --2.
    insert into tblwomen (name, age, height, weight, couple)
        values(vrow.name, vrow.age, vrow.height, vrow.weight, vrow.couple);
        
    --3. 
    delete from tblmen where name =  vrow.name;
    
end;

-------------------------------------------------------

/*

    제어문
    1. 조건문
    2. 반복문
    3. 분기문

*/
--양수입니까
declare
    vnum number := 10;
begin

    if vnum > 0 then
        dbms_output.put_line('양수');
    end if;

end;


------------
--음수 입니까
declare
    vnum number := -10;
begin

    if vnum > 0 then
        dbms_output.put_line('양수');
    else
        dbms_output.put_line('음수');
    end if;

end;

-------------------
-- 0입니까

declare
    vnum number := 0;
begin

    if vnum > 0 then
        dbms_output.put_line('양수');
    elsif vnum < 0 then
        dbms_output.put_line('음수');
    else 
        dbms_output.put_line('0');
    end if;

end;

----------------------
-- tblinsa. 남자 직원/여자 직원 > 다른 업무

declare
    vgender char(1);
begin

    select substr(ssn, 8, 1)into vgender from tblinsa where num = 1035;

    if vgender = '1' then
        dbms_output.put_line('남자직원');
    elsif vgender = '2' then
        dbms_output.put_line('여자직원');
    end if;
end;

-- 직원 1명 선택(num) > 보너스 지급
-- 차등 지급
-- a. 과장/부장 > basicpay * 1.5
-- b. 대리/사원 > basicpay * 2

declare
    vnum tblinsa.num%type;
    vbasicpay tblinsa.basicpay%type;
    vjikwi tblinsa.jikwi%type;
    vbonus number;
begin

    select num, basicpay,jikwi into vnum, vbasicpay, vjikwi
        from tblinsa where num = 1040;
    
    if vjikwi = '과장' or vjikwi = '부장' then
        vbonus := vbasicpay * 1.5;
    elsif vjikwi = '대리' or vjikwi ='사원' then
        vbonus := vbasicpay * 2;
    end if;
    
    insert into tblBonus (seq, num, bonus)
        values((select nvl(max(seq), 0) + 1 from tblbonus), vnum, vbonus);
end;

select 
    * 
from tblbonus b
    inner join tblinsa i
        on i.num = b.num;

/*

    case문
    - ANSI-SQL의 case문과 거의 유사
    - 자바의 Switch문, 다중 if문

*/

declare
    vcontinent tblCountry.continent%type;
    vresult varchar2(30);
begin

    select continent into vcontinent from tblcountry where name = '영국';
    
    if vcontinent = 'AS' then
        vresult := '아시아';
    elsif vcontinent = 'EU' then
        vresult := '유럽';
    elsif vcontinent = 'AF' then
        vresult := '아프리카';
    else
        vresult := '기타';
    end if;
    
    dbms_output.put_line(vresult);
    
    
    case
        when vcontinent = 'AS' then vresult := '아시아';
        when vcontinent = 'EU' then vresult := '유럽';
        when vcontinent = 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;
    
    dbms_output.put_line(vresult);
    
    case vcontinent
        when 'AS' then vresult := '아시아';
        when 'EU' then vresult := '유럽';
        when 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;
    
    dbms_output.put_line(vresult);
    
end;


/*

    반복문
    
    1. loop
        - 단순 반복
        
    2. for loop
        - 횟수 반복(자바 for)
        - loop 기반
        
    3. while loop
        - 조건 반복(자바 while)
        - loop 기반

*/

-- 1. loop
-- 무한 루프
begin 
    loop
        dbms_output.put_line('100');
    end loop;

end;

declare
    vnum number := 1;
begin
    loop
        dbms_output.put_line(vnum);
        vnum := vnum + 1;
    
        exit when vnum > 10; --조건부 break
    
    end loop;
end;

create table tblloop(

    seq number primary key,
    data varchar2(100) not null
);

create sequence seqloop;

-- 데이터 x 1000rjs cnrk
-- data > '항목1' , '항목2', .. '항목1000'

declare
    vnum number := 1;
begin
    loop
        insert into tblloop values (seqloop.nextVal, '항목' || vnum);
        vnum := vnum + 1;
        exit when vnum > 1000;
    end loop;
end;

select * from tblloop;



--2. for loop
/*

    향상된 for 문
    - foreach문
    - for in
    
    for(int n : list) {
    }
    
    for (int n in list) {
    }

*/

begin
    for i in 1..10 loop
        dbms_output.put_line(i);   
    end loop;
end;

-------------------------
drop table tblgugudan;

create table tblGugudan(
    dan number not null ,
    num number not null ,
    result number not null,
    constraint tblgugudan_dan_num_pk primary key(dan, num) --복합키(Composite Key)
);


----------------------------

create table tblGugudan(
    dan number not null ,
    num number not null ,
    result number not null
);

alter table tblgugudan
    add constraint tblgugudan_dan_num_pk primary key(dan, num);

begin

    for dan in 2..9 loop
        for num in 1..9 loop
         insert into tblgugudan (dan,num,result)
            values(dan, num, dan * num);
        end loop;
    end loop;
end;

select * from tblgugudan;

-----------------------------------


begin
    for i in reverse 1..10 loop
        dbms_output.put_line(i);   
    end loop;
end;

----------------------------------
--3. while loop
declare
    vnum number := 1;
begin
   loop
        dbms_output.put_line(vnum);   
        vnum := vnum + 1;
        exit when vnum > 10;
    end loop;
end;


declare
    vnum number := 1;
begin
   while vnum <= 10 loop
        dbms_output.put_line(vnum);   
        vnum := vnum + 1;
    end loop;
end;

/*

    select > 결과셋 > PL/SQL 변수 대입
    
    1. select into
        - 결과셋의 레코드가 1개일 때만 사용이 가능하다.
        
    2. cursor
        - 결과셋의 레코드가 N개일 때 사용한다.
        - 루프 사용
        
    declare
        변수 선언;
        커서 선언; -- 결과셋 참조 객체
    begin
        커서 열기;
            loop
                데이터 접근(루프 1회전 > 레코드 1개) <- 커서 사용
            end loop;
        커서 닫기;
    end;

*/

declare
    vname tblinsa.name%type;
    vname := 1; 
begin
    select name into vname from tblinsa;
    dbms_output.put_line(vname);
    
end;

--
--create view vview
--as
--select문
--
--cursor vcursor
--is select문;

declare
    cursor vcursor 
    is
    select name from tblinsa;
    vname tblinsa.name%type;
begin

    open vcursor; --커서 열기 > select 실행 > 결과셋을 커서가 참조
--    
--        fetch vcursor into vname; -- select into 역할
--        dbms_output.put_line(vname);
--        
--        
--        fetch vcursor into vname; -- select into 역할
--        dbms_output.put_line(vname);
 --FOR 루프       
--        for i in 1..60 loop
--            fetch vcursor into vname;
--            dbms_output.put_line(vname);
--        end loop;
    
    loop
        fetch vcursor into vname;
        exit when vcursor%notfound; -- bool
        
        dbms_output.put_line(vname);
    end loop;
        
    close vcursor;

end;

-- '기획부' > 이름 , 직위, 급여 > 출력
declare
    cursor vcursor
        is select name, jikwi, basicpay from tblinsa where buseo = '기획부';
    vname tblinsa.name%type;
    vjikwi tblinsa.jikwi%type;
    vbasicpay tblinsa.basicpay%type;
begin

    open vcursor;
    
    loop
        fetch vcursor into vname, vjikwi, vbasicpay;
        exit when vcursor%notfound;
        
        --업무 > 기획부 직원 한사람씩 접근..
        dbms_output.put_line(vname || ',' || vjikwi || ',' || vbasicpay);
    end loop;
    
    close vcursor;

end;


-- 문제. tblBonus
-- 모든 직원에게 보너스 지급. 60명 전원 > 과장/부장 (1.5), 사원/대리(2) 지급
select * from tblBonus;

declare
    
    cursor vcursor
        is select num, basicpay, jikwi from tblInsa;
        
    vnum tblInsa.num%type;
    vbasicpay tblInsa.basicpay%type;
    vjikwi tblInsa.jikwi%type;
    vbonus number;
    
begin
    
    open vcursor;
    loop
        fetch vcursor into vnum, vbasicpay, vjikwi;
        exit when vcursor%notfound;
        
        if vjikwi in ('과장', '부장') then
            vbonus := vbasicpay * 1.5;
        elsif vjikwi in ('사원', '대리') then
            vbonus := vbasicpay * 2;
        end if;
        
        insert into tblBonus (seq, num, bonus)
            values ((select nvl(max(seq), 0) + 1 from tblBonus), vnum, vbonus);
        
    end loop;
    close vcursor;

end;

select 
    * 
from tblbonus b
    inner join tblinsa i
        on i.num = b.num;
------------

-- 커서 탐색
-- 1. 커서 + loop > 정석
-- 2. 커서 + for loop > 간결

declare
    cursor vcursor
    is select * from tblinsa;
    vrow tblinsa%rowtype;
begin
   -- open vcursor;
    --loop
    for vrow in vcursor loop -- loop + fetch into + vrow + exit when
        --fetch vcursor into vrow;
        --exit when vcursor%notfound;
        dbms_output.put_line(vrow.name);
    end loop;
   -- close vcursor;
end;

--주석 지운거
declare
    cursor vcursor
    is select * from tblinsa;
    vrow tblinsa%rowtype;
begin
    for vrow in vcursor loop
        dbms_output.put_line(vrow.name);
    end loop;
end;

-- 예외처리
-- : 실행부에서(being~end) 발생하는 예외를 처리하는 블럭 > exception 블럭

declare
    vname varchar2(5);
begin --구현부(try)
    dbms_output.put_line('하나');
    select name into vname from tblinsa where num = 1001;
    dbms_output.put_line('둘');
    
    dbms_output.put_line(vname);
    
exception --예외처리부(catch)

    when others then
        dbms_output.put_line('예외 처리');
    
end;

-- 예외 발생 > DB 저장
create table tbllog(
    seq number primary key,                 --PK
    code varchar2(7) not null check(code in('A001', 'B001', 'B002', 'C001')), --에러 상태 코드
    message varchar2(1000) not null,        --에러 메시지
    regdate date default sysdate not null   --에러 발생 시각
);

create sequence seqlog;

declare
    vcnt number;
    vname tblinsa.name%type;
    
begin

    select count(*) into vcnt from tblCountry; --where name = '태국';
    dbms_output.put_line(100 / vcnt);

    select name into vname from tblinsa where num = 1000;
    dbms_output.put_line(vname);
    
exception

    when ZERO_DIVIDE then
    dbms_output.put_line('0으로 나누기');
    insert into tbllog 
        values (seqlog.nextVal, 'B001', '가져온 레코드가 없습니다.', default);
    
    when no_data_found then
    dbms_output.put_line('데이터 없음');
    insert into tbllog 
        values (seqlog.nextVal, 'A001', '직원이 존재하지 않습니다.', default);
    
    when others then
    dbms_output.put_line('나머지 예외');
    insert into tbllog 
        values (seqlog.nextVal, 'C001', '기타 예외가 발생했습니다.', default);
        
end;

신수정 바보~~

select * from tbllog;

-- ~ 익명 프로시저

-- 실명 프로시저 ~


/*

    명령어 실행 > 처리 과정

    1. ANSI-SQL
    2. 익명 프로시저
        a. 클라이언트 > 구문 작성(select)
        b. 실행 (ctrl + enter)
        c. 명령어를 오라클 서버에 전달
        d. 서버가 명령어를 수신
        e. 구문 분석(파싱) + 문법 검사
        f. 컴파일
        g. 실행(select)
        h. 결과셋 도출
        i. 결과셋을 클라이언트에게 반환
        j. 결과셋을 화면에 출력
        
    2. 다시실행
        a ~ j 까지 다시 반복
        - 한번 실행했던 명령어를 다시 실행 > 위의 모든 과정을 처름부터 끝까지 다시 실행한다.
        - 첫번째 실행 비용 = 다시 실행 비용
        
    3. 실명 프로시저
        a. 클라이언트 > 구문작성(create)
        b. 실행 (ctrl + enter)
        c. 명령어를 오라클 서버에 전달
        d. 서버가 명령어를 수신
        e. 구문 분석(파싱) + 문법 검사
        f. 컴파일
        g. 실행(select)
        h. 오라클 서버 > 프로시저 생성 > 저장
        i. 완료
        
        a. 클라이언트 > 구문작성(create)
        b. 실행 (ctrl + enter)
        c. 명령어를 오라클 서버에 전달
        d. 서버가 명령어를 수신
        e. 구문 분석(파싱) + 문법 검사
        f. 컴파일
        g. 실행(select) > 프로시저 실행
        
    4. 다시시작
        a. 클라이언트 > 구문작성(create)
        b. 실행 (ctrl + enter)
        c. 명령어를 오라클 서버에 전달
        d. 서버가 명령어를 수신
        e. 구문 분석(파싱) + 문법 검사
        f. 컴파일
        g. 실행(select) > 프로시저 실행
*/
select * from tblinsa;

/*

    프로시저
    1. 익명 프로시저
        - 1회용
        
    2. 실명 프로시저
        - 재사용
        - 오라클에 저장

    실명 프로시저
    - 저장 프로시저(Stored Procedure)
    1. 저장 프로시저, Stored Procedure
        - 매개변수 / 반환값 구성 > 자유
    2. 저장 함수, Stored Function
        - 매개변수 / 반환값 구성 > 필수
        
        >> 굳이 따지면 저장 프로시저가 좀 더 넓은 의미
        
----------------------------------------        
    익명 프로시저 선언
    
    [declare
        변수 선언;
        커서 선언;]
    begin
        구현부;
   [exception
        예외처리;]
    end;
    
    [] >> 생략 가능
    
----------------------------------------    
    저장 프로시저 선언
    
    create [or replace] procedure 프로시저명
    is(as)
        [변수 선언;
        커서 선언;]
    begin
        구현부;
   [exception
        예외처리;]
    end;
*/

-- 즉시 실행
declare
    vnum number;
begin
    vnum := 100;
    dbms_output.put_line(vnum);
end;


-----------------------------
-- 저장 프로시저
create or replace procedure proctest
is
    vnum number;
begin
    vnum := 100;
    dbms_output.put_line(vnum);
end;

--저장 프로시저를 호출하는 방법
    
    begin
        proctest;--프로시저 호출
    end;


-- 저장 프로시저 = 메서드
-- 매개변수 + 반환값

-- 1. 매개변수가 있는 프로시저
create or replace procedure proctest(pnum number) -- 매개변수
is 
    vresult number ; -- 일반변수
begin

    vresult := pnum * 2;
    dbms_output.put_line(vresult);

end procTest;

--호출
begin
    procTest(100);
    procTest(200);
    procTest(300);
end;

-- 무슨 영역?
-- ANSI-SQL 영역
select * from tblinsa;

execute procTest(400);
exec procTest(500);
call procTest(600);


create or replace procedure procTest(
    width number,
    height number
)
is
    vresult number;
begin
    vresult := width * height;
    dbms_output.put_line(vresult);
end procTest;

begin
    procTest(10, 20);
end;

-----------------------------------
-- *** 프로시저 매개변수는 길이와 not null 표현은 불가능하다.
create or replace procedure procTest(
    name varchar2
)

is -- 변수 선언이 없어도 반드시 기재
begin

    dbms_output.put_line('안녕하세요.' || name || '님');

end procTest;

begin
    proctest('홍길동');
end ;

-------------------------------
create or replace procedure procTest(
    width number,
    height number default 10
)
is
    vresult number;
begin
    vresult := width * height;
    dbms_output.put_line(vresult);
end procTest;

begin
    procTest(10, 20);   -- width(10), height(20)
    procTest(10);       -- width(10), height(10-default)
end;

/*

    매개변수 모드
    - 매개변수가 값을 전달하는 방식
    - Call by Value > 매개변수 > 값을 넘기는 방식(값형 인자)
    - Call by Reference > 매개변수 > 참조값(주소)을 넘기는 방식(참조형 인자)
    
    1. in 모드
    2. out 모드
    3. in out 모드(X)

*/

create or replace procedure procTest(
    pnum1 number,           -- in parameter//인자값
    pnum2 number,
    presult out number,     -- out parameter//반환값 역할
    presult2 out number,    -- 반환값
    presult3 out number     -- 반환값
)
is
begin
    presult := pnum1 + pnum2;
    presult2 := pnum1 - pnum2;
    presult2 := pnum1 * pnum2;
    
end procTest;


declare
    vnum number;
    vnum2 number;
    vnum3 number;
begin
    procTest(10, 20, vnum, vnum2, vnum3);
    dbms_output.put_line(vnum);
    dbms_output.put_line(vnum2);
    dbms_output.put_line(vnum3);
end;

-------------------------------
-- 문제
-- 1. 부서 전달(인자) > 해당 부서의 직원 중 급여를 가장 많이 받는 사람의 번호를 반환(out) > 출력
-- in 1개 + out 1개
-- 2. 직원 번호 전달(인자) > 같은 지역에 사는 직원수?, 같은 직위인 직원수? 해당 직원보다 급여를 더 많이 받는 직원수 ? 반환
-- in 1개 + out 3개
create or replace procedure procTest1(
    pbuseo varchar2,
    pnum out number
)
is
begin
    select num into pnum from tblinsa
        where basicpay = (select max(basicpay) from tblinsa where buseo = pbuseo)
            and buseo = pbuseo;
end procTest1;

declare
    vnum number; --out 에게 넘길 변수
begin
    procTest1('영업부', vnum);
    dbms_output.put_line(vnum);
end;
    
select * from tblinsa;
------------------------
-- 2. 직원 번호 전달(인자) > 같은 지역에 사는 직원수?, 같은 직위인 직원수? 해당 직원보다 급여를 더 많이 받는 직원수 ? 반환
-- in 1개 + out 3개
create or replace procedure procTest2(
    pnum in number,
    pcnt1 out number,
    pcnt2 out number,
    pcnt3 out number
)
is
begin
    select count(*) into pcnt1 from tblinsa where city = (select city from tblinsa where num = pnum);
    select count(*) into pcnt2 from tblinsa where jikwi = (select jikwi from tblinsa where num = pnum);
    select count(*) into pcnt3 from tblinsa where basicpay > (select basicpay from tblinsa where num = pnum);
    
end procTest2;

declare
    vcnt1 number;
    vcnt2 number;
    vcnt3 number;    
begin
    procTest2(1023, vcnt1, vcnt2, vcnt3);
    dbms_output.put_line(vcnt1);
    dbms_output.put_line(vcnt2);
    dbms_output.put_line(vcnt3);
end;
---------
--합치기
declare
    vnum number;
    vcnt1 number;
    vcnt2 number;
    vcnt3 number;    
begin
    procTest1('개발부', vnum),
    procTest2(1023, vcnt1, vcnt2, vcnt3);
    dbms_output.put_line(vcnt1);
    dbms_output.put_line(vcnt2);
    dbms_output.put_line(vcnt3);
end;


select * from tblStaff;
select * from tblProject;

delete from tblstaff;
delete from tblproject;


INSERT INTO tblStaff (seq, name, salary, address) VALUES (1, '홍길동', 300, '서울시');
INSERT INTO tblStaff (seq, name, salary, address) VALUES (2, '아무개', 250, '인천시');
INSERT INTO tblStaff (seq, name, salary, address) VALUES (3, '하하하', 250, '부산시');

INSERT INTO tblProject (seq, project, staff_seq) VALUES (1, '홍콩 수출', 1); --홍길동
INSERT INTO tblProject (seq, project, staff_seq) VALUES (2, 'TV 광고', 2); --아무개
INSERT INTO tblProject (seq, project, staff_seq) VALUES (3, '매출 분석', 3); --하하하
INSERT INTO tblProject (seq, project, staff_seq) VALUES (4, '노조 협상', 1); --홍길동
INSERT INTO tblProject (seq, project, staff_seq) VALUES (5, '대리점 분양', 2); --아무개

commit;


-- 직원 퇴사 프로시저, procDeleteStaff
-- 1. 퇴사 직원 > 담당 프로젝트 유무 확인?
-- 2. 담당 프로젝트 존재 > 위임
-- 3. 퇴사 직원 삭제

create or replace procedure procDeleteStaff(
    pseq number,            --퇴사할 직원번호
    pstaff number,          --위임받을 직원번호
    presult out number      --성공(1) or 실패(0) > 피드백
)
is
    vcnt number; --퇴사 직원의 담당 프로젝트 개수
begin

    -- 1. 퇴사 직원의 담당 프로젝트가 있는지?
    select count(*) into vcnt from tblProject where staff_seq = pseq;

    -- 2. 조건 > 위임 유무결정
    if vcnt > 0 then
        --3. 위임
        update tblProject set staff_seq = pstaff where staff_seq = pseq;
    else
        --3. 아무것도 안함
        null; -- 이 조건의 else 절에서는 아무것도 하지 마시오!! > 개발자의 의도를 표현
    end if;
    
    --4. 퇴사
    delete from tblstaff where seq = pseq;
    
    -- 5. 피드백 > 성공
    presult := 1; 
    
exception
    when others then
        presult := 0;
    
end procDeleteStaff;

declare
    vresult number;
begin
    procDeleteStaff(1, 2, vresult);

    if vresult = 1 then
        dbms_output.put_line('퇴사 성공');
    else
        dbms_output.put_line('퇴사 실패');
        
    end if;
end;

select * from tblproject;

insert into tblstaff values(4, '호호호', 200, '서울시');
-------------------------------------------------
-- 위임 받을 직원 > 현재 프로젝트를 가장 적게 담당하는 직원에게 자동으로 위임
-- 동률 > rownum = 1
create or replace procedure procDeleteStaff(
    pseq number,            --퇴사할 직원번호
    presult out number      --성공(1) or 실패(0) > 피드백
)
is
    vcnt number; --퇴사 직원의 담당 프로젝트 개수
    vstaff_seq number; --담당 프로젝트가 가장 적은 직원 번호
begin

    -- 1. 퇴사 직원의 담당 프로젝트가 있는지?
    select count(*) into vcnt from tblProject where staff_seq = pseq;

    -- 2. 조건 > 위임 유무결정
    if vcnt > 0 then
    
        --2.5 프로젝트 적게 담당하고 있는 직원 번호?
       select seq into vstaff_seq from (
            select 
                s.seq
            from tblStaff s
                left outer join tblProject p
                    on s.seq = p.staff_seq
                        group by s.seq
                            having count(p.staff_seq) = (select                                                             
                                                                min(count(p.staff_seq))
                                                            from tblStaff s
                                                                left outer join tblProject p
                                                                    on s.seq = p.staff_seq
                                                                        group by s.seq))
                                                                         where rownum = 1;
        --3. 위임
        update tblProject set staff_seq = vstaff_seq where staff_seq = pseq;
    else
        --3. 아무것도 안함
        null; -- 이 조건의 else 절에서는 아무것도 하지 마시오!! > 개발자의 의도를 표현
    end if;
    
    --4. 퇴사
    delete from tblstaff where seq = pseq;
    
    -- 5. 피드백 > 성공
    presult := 1; 
    
exception
    when others then
        presult := 0;
    
end procDeleteStaff;

/*

    저장 프로시저
    1. 저장 프로시저
    2. 저장 함수
    
    저장 함수, Stored Function > 함수(Function)
    - 저장 프로시저와 동일
    - 반환값이 반드시 존재 > out 파라미터를 말하는게 아니라 > return 문을 사용한다.
    - out 파라미터를 사용 금지 > 대신 return 문을 사용
    - in 파라미터는 사용한다.
    - 이런 특성 때문에 호출하는 구문이 조금 다르다. (***)
*/

-- num1 + num2 > 합

-- 프로시저
set serveroutput on;

CREATE OR REPLACE PROCEDURE procSum(
    num1 IN NUMBER,
    num2 IN NUMBER,
    presult OUT NUMBER
)
IS
BEGIN
    presult := num1 + num2;
END procSum;


-- 함수
create or replace function fnSum(
    num1 in number,
    num2 in number
   --presult out number -- out을 사용하면 함수의 고유 특성이 사라진다. 프로시저와 동일
) return number
is
begin
    --presult := num1 + num2;
    
    return num1 + num2;
    
end fnSum;


declare
    vresult number;
begin
    procSum(10, 20, vresult);
    dbms_output.put_line(vresult);
    
    vresult := fnSum(10, 20);
    dbms_output.put_line(vresult);
end;

--프로시저: PL/SQL 전용 > 업무 절차 모듈화
-- 함수: ANSI-SQL 보조

select
    name,
    basicpay,
    sudang,
--    procSum(basicpay, sudang, 변수)
    fnSum(basicpay, sudang)
from tblinsa;

-- 이름, 부서, 직위, 성별(남자|여자)
select
    name,
    buseo,
    jikwi,
    case
        when substr(ssn, 8, 1) = '1' then '남자'
        when substr(ssn, 8, 1) = '2' then '여자'
    end as gender,
    fnGender(ssn) as gender2
from tblinsa;
------
--함수로
create or replace function fnGender(pssn varchar2) return varchar2
is
begin

    return case
                when substr(pssn, 8, 1) = '1' then '남자'
                when substr(pssn, 8, 1) = '2' then '여자'
            end;

end fnGender;


/*
    프로시저
    1. 프로시저
    2. 함수
    3. 트리거

    트리거, Trigger
    - 프로시저의 한 종류
    - 개발자의 호출이 아닌, 미리 지정한 특정 사건이 발생하면 시스템이 자동으로 실행하는 프로시저
    - 예약(사건) > 사건 발생 > 프로시저 호출
    - 특정 테이블 지정 > 지저 테이블 오라클 감시 >
        > insert or update or delete > 미리 준비해놓은 프로시저 호출
        
    트리거 구문
    create or replace trigger 트리거명
        before|afrer
        insert|update|delete
        on 테이블명
        [for each row]
    declare
        선언부;
    begin
        구현부;
    exception
        예외처리부;
    end;

*/

--tblinsa > 직원 삭제
create or replace trigger trginsa
    before     -- 삭제가 발생하기 직전에 아래의 구현부를 먼저 실행해라!!
    delete     -- 삭제가 발생하는지 감시?
    on tblinsa -- tblinsa 테이블에서(감시)
begin
    dbms_output.put_line(to_char(sysdate, 'hh24:mi:ss') || '트리거가 실행되었습니다.');
    
    -- 월요일에는 퇴사가 불가능
    if to_char(sysdate, 'dy') = '월' then
    
        --강제로 에러 발생
        -- throw new Exception() > java에서 에러내기
        -- 앞에 적는 에러 번호는 보통 -20000 ~ -29999
        raise_application_error(-20001, '월요일에는 퇴사가 불가능합니다.');
    end if;
end trginsa;

delete from tblinsa where num = 1010; --자식테이블이 있어서 실행이 안됨

delete from tblbonus; --보너스 테이블 삭제



-- 로그 기록
drop table tblLogDiary;
drop sequence seqlogdiary;
create table tblLogDiary(
    seq number primary key,
    message varchar2(1000) not null,
    regdate date default sysdate not null
);

create sequence seqLogDiary;

create or replace trigger trgDiary
    after
    insert or update or delete
    on tbldiary
declare
    vmessage varchar2(1000);
begin
    --dbms_output.put_line(to_char(sysdate, 'hh24:mi:ss') || '트리거가 실행되었습니다.');
    if inserting then
--   dbms_output.put_line('추가');
        vmessage := '새로운 항목이 추가되었습니다.';
    elsif updating then
--    dbms_output.put_line('수정');
    vmessage := '기존 항목이 수정되었습니다.';
    elsif deleting then
--    dbms_output.put_line('삭제');
    vmessage := '새로운 항목이 삭제되었습니다.';
    end if;

    insert into tblLogDiary values(seqLogDiary.nextVal, vmessage, default)

end trDiary;

insert into tbldiary values (11, '프로시저를 공부했다.', '흐림', sysdate);

update tbldiary set subject = '프로시저를 복습했다.' where seq = 11;

delete from tbldiary where seq = 11;


/*

    [for each row]
    
    1. 생략
        - 문장(Query) 단위 트리거
        - 사건에 적용된 행의 갯수와 무관 > 트리거 딱 1회 호출
        - 적용된 레코드의 정보는 중요하지 않은 경우 + 사건 자체가 중요한 경우
    2. 사용
        - 행(record) 단위 트리거. Table level trigger
        - 사건에 적용된 행의 개수만큼 > 트리거가 호출
        - 적용된 레코드의 정보가 중요한 경우 + 사건 자체보다..
        - 상관 관계를 사용한다. > 일종의 가상 레코드 > : old , :new
        
        insert
        - :new > 방금 추가된 행
        
        update
        - :old > 수정되기 전 행 
        - :new > 수정된   후 행
        
        delete
        - :old > 삭제되기 전 행
*/
rollback;

select * from tblMen;

create or replace trigger trgMen
    after
    delete
    on tblMen
    for each row
begin
    dbms_output.put_line('레코드를 삭제했습니다.' || :old.name);
end trgMen;
-----
delete from tblMen where name = '홍길동'; --1명 삭제

delete from tblMen where age < 25 ; --3명 삭제

INSERT INTO tblmen VALUES ('홍길동', 25, 180, 70, '장도연');
INSERT INTO tblmen VALUES ('아무개', 22, 175, NULL, '이세영');
INSERT INTO tblmen VALUES ('하하하', 27, NULL, 80, NULL);
INSERT INTO tblmen VALUES ('무명씨', 21, 177, 72, NULL);
INSERT INTO tblmen VALUES ('정형돈', 28, NULL, 92, NULL);
INSERT INTO tblmen VALUES ('양세형', 22, 166, 55, '김민경');
INSERT INTO tblmen VALUES ('조세호', 24, 165, 58, '오나미');

---------
--update 트리거
create or replace trigger tblmen
    after
    update
    on tblMen
    for each row
begin

    dbms_output.put_line('레코드를 수정했습니다. >' || :old.name);
    dbms_output.put_line('수정하기 전 나이: ' || :old.age);
    dbms_output.put_line('수정하기 후 나이:' || :new.age);

end trgMen;

update tblMen set age = age + 1 where name = '홍길동';
update tblmen set age = age + 1;

--------------
-- 퇴사 > 프로젝트 위임
select * from tblstaff;
select * from tblproject;

-- 직원을 퇴사 > 퇴사 바로 직전 > 담당 프로젝트 체크 > 위임
create or replace trigger trgDeleteStaff
    before          --3. 전에
    delete          --2. 퇴사
    on tblstaff     --1. 직원 테이블에서
    for each row    --4. 해당 직원 정보
begin

    --5. 위임 진행
    update tblProject set
        staff_seq = 3
            where staff_seq = :old.seq; --퇴사하는 직원 번호
            
end trgDeleteStaff;

select * from tblstaff;

select * from tblproject;

delete from tblstaff where seq = 1;
--------------------------------------

-- 회원 테이블, 게시판 테이블
-- 포인트 제도
-- 1. 글 작성 > 포인트 + 100
-- 2. 글 삭제 > 포인트 - 50

create table tbluser(
    id varchar2(30) primary key,
    point number default 1000 not null
);

create table tblboard(
    seq number primary key,
    subject varchar2(1000) not null,
    id varchar2(30) not null references tbluser(id)
);

create sequence seqboard;

insert into tbluser values('hong', default);


-- A. 글을 쓴다.(삭제한다.)
-- B. 포인트를 누적(차감)한다.


-- Case 1. Hard
-- 개발자가 직접 제어
-- 실수 > 일부 업무 누락 ;;(이에 대한 안전장치가 없는게 단점/ 포인트 관리가 잘 안될 수 있음)

-- 1.1 글쓰기
insert into tblboard values (seqBoard.nextVal, '게시판입니다.', 'hong')

-- 1.2 포인트 누적하기
update tbluser set point = point + 100 where id = 'hong';

-- 1.3 글삭제
delete from tblboard where seq = 1;

-- 1.4 포인트 차감하기
update tbluser set point = point - 50 where id = 'hong';

select * from tbluser;

-- Case 2. 프로시저
create or replace procedure procAddBoard(
    pid varchar2,
    psubject varchar2
)
is
begin

    --2.1 글쓰기
    insert into tblboard values (seqBoard.nextVal, psubject, pid);
    
    --2.2 포인트 누적하기
    update tbluser set point = point + 100 where id = pid;
end procAddboard;

create or replace procedure procDeleteBoard(
    pseq number
)
is
    vid varchar2(30);
begin
    
    --2.1 삭제글의 작성자 알아내기
    select id into vid from tblboard where seq = pseq;
    
    --2.2 글삭제
    delete from tblboard where seq = pseq;
    
    --2.3 포인트 차감하기
    update tbluser set point = point - 50 where id = vid;

end procDeleteboard;


---

begin
   -- procaddboard('hong', '글을 작성합니다.');
   procDelecteBoard(2);
end;

-- Case 3. 트리거
create or replace trigger trgboard
    after
    insert of delete
    on tblboard
    for each row
begin
    if inserting then
        update tbluser set point = point + 100 where id = :new.id;
    elsif deleting then
        update tbluser set point = point - 50 where id = :old.id;
    end if;
    
end trgboard;

insert into tblBoard values (seqBoard.nextVal, '또 다시 글을 씁니다.', 'hong');

delete from tblBoard where seq = 5;


/*

    g함수 return
    
    1. 단일값 O
    2. 다중값 > cursor
    프로시저 out parameter
    
    1. 단일값(단일 레코드)
        a. number
        b. varchar2
        c. date
        
    2. 다중값(다중 레코드)\
        a. cursor

*/
set serveroutput on;
create or replace procedure procBuseo(
    pbuseo varchar2
)
is
    cursor vcursor
    is
    select * from tblinsa where buseo = pbuseo;
    
    vrow tblinsa%rowtype;
begin

    open vcursor;
    loop
        fetch vcursor into vrow; --select into
        exit when vcursor%notfound;
        
        --업무
        dbms_output.put_line(vrow.name || ',' || vrow.buseo);
        
    end loop;
    close vcursor;
end procBuseo;

begin
    procbuseo('영업부');
end;

---------------
create or replace procedure procbuseo(
    pbuseo in varchar2,
    pcursor out sys_refcursor -- 커서의 자료형
)
is
begin

    open pcursor
    for
    select * from tblinsa where buseo = pbuseo;
    
end procbuseo;

declare
    vcursor sys_refcursor;--커서 참조 변수 
    vrow tblinsa%rowtype;
begin

    procbuseo('영업부', vcursor);
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        --업무
        dbms_output.put_line(vrow.name);
        
    end loop;
end;


-- 프로시저 총 정리 > CRUD

--1. 추가 작업(C)
create or replace procedure 추가작업(
    추가할 데이터 -> in 매개변수,
    추가할 데이터 -> in 매개변수,
    추가할 데이터 -> in 매개변수, --원하는 만큼
    성공 유무 반환 -> out 매개변수 -- 피트백(1,0)
)
is
    내부 변수 선언
begin
    작업(insert + (select, update, delete))
exception
    when others then
        예외처리
end;

-- 할일 추가하기(C)
select * from tbltodo; --23
create or replace procedure procAddtodo(
    ptitle varchar2,
    presult out number --1 or 0
    
)
is
begin

    insert into tbltodo(seq, title, adddate, completedate)
        values(seqtodo.nextVal, ptitle, sysdate, null);
        
    presult := 1;
exception
    when others then
        presult := 0; --실패
end procAddtodo;

create sequence seqtodo start with 24;


declare
    vresult number;
begin
    procAddtodo('새로운 할일입니다.', vresult);
    dbms_output.put_line(vresult);
end;

select * from tbltodo;

-- 2. 수정 작업(U)
create or replace procedure 수정작업(
    수정할 데이터 -> in 매개변수,
    수정할 데이터 -> in 매개변수,
    수정할 데이터 -> in 매개변수, --원하는 개수
    식별자       -> in 매개변수 --where절에 사용할 PK or 데이터
    성공 유무 반환 -> out 매개변수 -- 피트백(1,0)
)
is
    내부 변수 선언
begin
    작업(update + (insert, update, delete, select..))
exception
    when others then   
        예외처리
end;

-- 할 일 수정하기(U) > completedate > 채우기 > 할일 완료 처리하기
create or replace procedure procCompletetodo(
--    pcompletedate date > 수정할 날짜 > 지금 > sysdate 처리
    pseq in number, --수정할 할일 번호
    presult out number
)
is
begin
    update tbltodo set
        completedate = sysdate
            where seq = pseq;
    presult := 1;
exception
    when others then
        presult := 0;
end procCompletetodo;


declare
    vresult number;
begin
    procCompletetodo(24, vresult);
    dbms_output.put_line(vresult);
end;


select * from tbltodo;


-- 3. 삭제 작업(D)
create or replace procedure 삭제작업(
    식별자 -> in 매개변수,
    성공 유무 반환 -> out 매개변수
)
is
     내부 변수 선언
begin
    작업(delete + (insert, update, delete, select))
exception
    when others then
        예외처리
end;


-- 할 일 삭제하기(D)
create or replace procedure procDeletetodo(
    pseq in number,
    presult out number
)
is
begin
    delete from tbltodo where seq = pseq;
    presult := 1;
exception
    when others then
        presult := 0;
end procDeletetodo;

declare
    vresult number;
begin
    procDeletetodo(24, vresult);
    dbms_output.put_line(vresult);
end;

select * from tbltodo;


-- 4. 읽기 작업(R)
-- : 조건 유무/
-- : 반환 단일행/다중행, 단일컬럼/다중컬럼

-- 한일 몇개? 안한일 몇개? 총 몇개?
create or replace procedure 읽기작업(
    조건 데이터 -> int 매개변수,
    단일 반환값 -> out 매개변수,
    다중 반환값 -> out 매개변수(커서)
)
is
    내부 변수 선언
begin
    작업(select + (insert, update, delete, select))
exception
    when others then
        예외처리
end;

-- 한일 몇개? 안한일 몇개? 총 몇개?
create or replace procedure procCounttodo(
    pcount1 out number, --한일
    pcount2 out number, --안한일
    pcount3 out number --모든일
)
is
begin
    select count(*) into pcount1 from tbltodo where completedate is not null;
    select count(*) into pcount2 from tbltodo where completedate is null;
    select count(*) into pcount3 from tbltodo;
exception
    when others then
        dbms_output.put_line('예외 처리'); --실제로는 log를 남김
end;

declare
    vcount1 number;
    vcount2 number;
    vcount3 number;
begin
    procCounttodo(vcount1, vcount2, vcount3);
    dbms_output.put_line(vcount1);
    dbms_output.put_line(vcount2);
    dbms_output.put_line(vcount3);
end;

-----

create or replace procedure procCounttodo(
    psel in number,     --선택(1(한일), 2(안한일), 3(모든일))
    pcount out number   -- 
)
is
begin
    if psel = 1 then
        select count(*) into pcount from tbltodo where completedate is not null;
    elsif psel = 2 then
        select count(*) into pcount from tbltodo where completedate is null;
    elsif psel = 3 then
        select count(*) into pcount from tbltodo;
    end if;
exception
    when others then
        dbms_output.put_line('예외 처리'); --실제로는 log를 남김
end;

declare
    vcount number;
begin
    procCounttodo(3, vcount);
    dbms_output.put_line(vcount);
end;

-- 번호 > 할일 1개 반환
create or replace procedure procGettodo(
    pseq in number,
    prow out tbltodo%rowtype
)
is
begin

    select * into prow from tbltodo where seq = pseq;
exception
    when others then
        dbms_output.put_line('예외 처리');
end;

declare
    vrow tbltodo%rowtype;
begin
    procGettodo(1, vrow);
    dbms_output.put_line(vrow.title);
end;

-- 다중 레코드 반환
-- 1. 한일 목록 반환
-- 2. 안한일 목록 반환
-- 3. 모든일 목록 반환
create or replace procedure procListtodo(
    psel in number,
    pcursor out sys_refcursor
)
is
begin

    if psel = 1 then
        open pcursor
        for
        select * from tbltodo where completedate is not null;
    elsif psel = 2 then
        open pcursor
        for
        select * from tbltodo where completedate is null;
    elsif psel = 3 then
        open pcursor
        for
        select * from tbltodo;
    end if;
exception
    when others then
        dbms_output.put_line('예외 처리');
end procListtodo;

declare
    vcursor sys_refcursor;
    vrow tbltodo%rowtype;
begin
    procListtodo(1, vcursor);
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.title || ',' || vrow.completedate);
        
    end loop;
    
end;








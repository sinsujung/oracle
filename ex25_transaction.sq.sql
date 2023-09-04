
-- ex25_transaction.sql

/*
	
	트랜잭션, Transaction
	- 데이터를 조작하는 업무의 물리적(시간적) 단위(행동의 범위)
	- 1개 이상의 명령어를 묶어 놓은 단위
	
	트랜잭션 관련 명령어, DCL(TCL)
	1. COMMIT
	2. ROLLBACK
	3. SAVEPOINT

*/


CREATE TABLE tbltrans
AS
SELECT name, buseo, jikwi FROM tblinsa WHERE city = '서울';


SELECT * FROM tbltrans;

-- 우리가 하는 행동을 시간 순으로 기억(*****)

-- 로그인 직후(접속) > 트랜잭션이 시작됨
-- 트랜잭션 > 모든 명령어가 기억되는 것이 아닌 데이터베이스에 영향을 미칠 수 있는 작업만 기억함
--			> INSERT, UPDATE, DELETE 명령어만 트랜잭션에 포함된다.
-- INSERT, UPDATE, DELETE 작업 > 오라클 적용(X), 임시 메모리 적용(O)

DELETE FROM tbltrans WHERE name = '박문수'; -- 트랜잭션에 포함

SELECT * FROM tbltrans; --트랜잭션과 무관


ROLLBACK; --현재 트랜잭션에서 했던 모든 행동을 데이터 베이스에 적용하지 말고 취소해라!!

SELECT * FROM tbltrans;

DELETE FROM tbltrans WHERE name = '박문수';

SELECT * FROM tbltrans;

COMMIT; -- 현재 트랜잭션에서 했던 모든 행동을 데이터베이스에 적용한다.

SELECT * FROM tbltrans;


DELETE FROM tbltrans WHERE name = '김영년';

SELECT * FROM tbltrans;

COMMIT ;

SELECT * FROM tbltrans;

INSERT INTO tbltrans values('호호호', '기획부', '사원');

UPDATE tbltrans SET jikwi = '상무' WHERE name = '홍길동';

SELECT * FROM tbltrans;

COMMIT;


/*

	트랜잭션이 언제 시작해서 ~ 언제 끝나는지?
	
	새로운 트랜잭션이 시작하는 시점
	
	1. 클라이언트가 접속하자마다(접속 직 후)
	2. commit 실행 직 후
	3. rollback 실행 직 후
	
	
	현재 트랜잭션이 종료되는 시점
	1. commit > 현재 트랜잭션을 종료 + DB에 반영
	2. rollback > 현재 트랜잭션을 종료 + DB에 반영
	3. 클라이언트가 접속을 종료하는 경우
		a. 정상 종료
			- 현재 트랜잭션에 아직 반영이 안된 명령어가 남아있는데 > 어떻게 할래? 질문
		b. 비정상 종료
			- 메모리 상(트랜잭션)의 모든 작업이 반영이 될만한 틈이 없이 강제 종료
			- rollback
	4. DDL 실행
		- Create, alter, drop > 실행 > 즉시 commit 실행
		- DDL 성격 때문 > 구조 변경 > 데이터 영향 끼침 > 사전에 미리 저장(commit) 
		
 */
UPDATE tbltrans SET jikwi = '부장' WHERE name = '홍길동';

SELECT * FROM tblinsa;

COMMIT;



SELECT * FROM tbltrans;

UPDATE tbltrans SET jikwi = '상무' WHERE name = '홍길동';

SELECT * FROM tbltrans;

UPDATE tbltrans SET jikwi = '부장' WHERE name = '홍길동';


COMMIT;


----------------
UPDATE tbltrans SET jikwi = '사장님' WHERE name = '홍길동';

SELECT * FROM tbltrans;

-- 시퀀스 객체 생성
CREATE SEQUENCE seqTrans; -- 현재 트랜잭션 COMMIT 동반

ROLLBACK;

SELECT * FROM tbltrans;



----------------

-- savepoint 라벨;

COMMIT;

SELECT * FROM tbltrans ; -- 홍길동	기획부	사장

INSERT INTO tbltrans VALUES ('후후후', '기획부', '직원');

SAVEPOINT a;

DELETE FROM tbltrans WHERE name = '홍길동';

SAVEPOINT b;

UPDATE tbltrans SET buseo = '개발부' WHERE name = '후후후';

SELECT * FROM tbltrans;

ROLLBACK TO b;

SELECT * FROM tbltrans;

ROLLBACK TO a;

SELECT * FROM tbltrans;

ROLLBACK;

SELECT * FROM tbltrans;



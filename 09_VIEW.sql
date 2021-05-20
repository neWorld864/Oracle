-- VIEW
-- SELECT 쿼리 실행 결과 화면을 저장한 객체, 논리적인 가상 테이블
-- 실제 데이터를 저장하고 있는 것은 아니지만 일반 테이블을 사용하는 것과 동일하게 쓸 수 있음
-- CREATE [OR REPLACE] VIEW 뷰이름 AS 서브쿼리;
-- OR REPLACE 옵션 : 뷰 생성 시 기존에 같은 이름의 뷰가 있다면 해당 뷰를 변경
-- OR REPLACE 옵션을 사용하지 않고 같은 이름의 뷰 생성 시 이미 다른 객체가 사용 중인 이름이라고 에러 발생

-- 사번, 이름, 부서명, 근무지역을 조회하고 그 결과를 V_EMPLOYEE라는 뷰를 생성해서 저장
CREATE OR REPLACE VIEW V_EMPLOYEE
AS
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
     LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
     LEFT JOIN NATIONAL USING (NATIONAL_CODE);
-- 오류 보고 - ORA-01031: insufficient privileges
-- 01031. 00000 -  "insufficient privileges" 
-- KH계정이 VIEW를 만들 수 있는 권한이 없다 -> SYSTEM계정이 권한을 줄 수 있다 -> SYSTEM계정으로 변환 후 권한을 주는 명령어 GRANT

-- 시스템 계정으로 변경 후 VIEW 생성 권한을 KH계정에 부여
GRANT CREATE VIEW TO KH;
-- GRANT을(를) 성공했습니다.가 뜨면 다시 KH 계정 변경 후 위 VIEW생성 쿼리 실행
-- View V_EMPLOYEE이(가) 생성되었습니다.

SELECT * FROM V_EMPLOYEE;

COMMIT;

SELECT * 
FROM EMPLOYEE
WHERE EMP_ID = 205;
-- 정중하

-- 사번이 205번인 사원의 이름을 정중앙으로 변경
UPDATE EMPLOYEE
SET EMP_NAME = '정중앙'
WHERE EMP_ID = 205;
-- 베이스 테이블의 정보가 변경되면 VIEW도 변경 됨

ROLLBACK;

-- 사번, 이름, 직급 명, 성별, 근무년수 조회
-- V_EMP_JOB VIEW에 결과 저장
CREATE OR REPLACE VIEW V_EMP_JOB(사번, 이름, 직급, 성별, 근무년수)
AS
SELECT EMP_ID, EMP_NAME, JOB_NAME,
       DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', '여'),
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE);
-- 오류 보고 - ORA-00998: must name this expression with a column alias
-- 서브쿼리에 있는 함수 때문에 꼭 별칭을 넣어줘야 한다
-- 별칭 기존처럼 입력해도 상관 없음

SELECT * FROM V_EMP_JOB;

-- 뷰를 이용하여 DML 사용 가능
-- 직급코드, 직급 명을 갖고 있는 VIEW V_JOB 생성
CREATE OR REPLACE VIEW V_JOB
AS
SELECT JOB_CODE, JOB_NAME
FROM JOB;

SELECT * FROM JOB;
SELECT * FROM V_JOB;

INSERT INTO V_JOB VALUES('J8', '인턴');
-- 뷰에서 요청한 DML문은 베이스 테이블도 변경

UPDATE V_JOB
SET JOB_NAME = '알바'
WHERE JOB_CODE = 'J8';

DELETE FROM V_JOB
WHERE JOB_CODE = 'J8'; -- 테이블과 뷰가 함께 삭제??

-- DML 명령어로 조작이 불가능한 경우
-- 1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
-- 2. 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 컬럼이 NOT NULL 제약조건이 지정된 경우
-- 3. 산술 표현식으로 정의된 경우
-- 4. 그룹함수나 GROUP BY절을 포함한 경우
-- 5. DISTINCT를 포함한 경우
-- 6. JOIN을 이용해 여러 테이블을 연결한 경우

-- 1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
CREATE OR REPLACE VIEW V_JOB2
AS SELECT JOB_CODE
   FROM JOB;

SELECT * FROM V_JOB2;

INSERT INTO V_JOB2 VALUES ('J8', '인턴');
-- 오류 보고 - SQL 오류: ORA-00942: table or view does not exist
-- V_JOB2에는 JOB_CODE만 있는데 JOB_NAME까지 넣으니까 오류

UPDATE V_JOB2
SET JOB_NAME = '인턴'
WHERE JOB_CODE = 'J7';
-- 오류 보고 - SQL 오류: ORA-00942: table or view does not exist

DELETE FROM V_JOB2
WHERE JOB_NAME = '사원';
-- 오류 보고 - SQL 오류: ORA-00942: table or view does not exist

-- 2. 뷰에 포함되지 않은 컬럼 중에, 베이스 테이블 컬럼이 NOT NULL 제약조건이 지정된 경우
CREATE OR REPLACE VIEW V_JOB3
AS SELECT JOB_NAME
   FROM JOB;

INSERT INTO V_JOB3 VALUES('인턴');
-- 오류 보고 - ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")

SELECT * FROM V_JOB3;

UPDATE V_JOB3
SET JOB_NAME = '알바'
WHERE JOB_NAME = '인턴';

DELETE FROM V_JOB3
WHERE JOB_NAME = '인턴';


-- 3. 산술 표현식으로 정의된 경우
CREATE OR REPLACE VIEW EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY,
          (SALARY + (SALARY*NVL(BONUS, 0)))*12 연봉
   FROM EMPLOYEE;

SELECT * FROM EMP_SAL;

INSERT INTO EMP_SAL
VALUES (800, '정진훈', 3000000, 360000000);
-- 오류 보고 - SQL 오류: ORA-01733: virtual column not allowed here
-- 가상 컬럼은 허용하지 않는다

UPDATE EMP_SAL
SET 연봉 = 100
WHERE EMP_ID = 200;
-- 오류 보고 - SQL 오류: ORA-01733: virtual column not allowed here

COMMIT;

DELETE FROM EMP_SAL
WHERE 연봉 = 124800000;

SELECT * FROM EMP_SAL;
SELECT * FROM EMPLOYEE;

ROLLBACK;

-- 4. 그룹함수나 GROUP BY절을 포함한 경우
-- 부서 코드, 부서 별 급여 합계(별칭 합계), 부서 별 급여 평균(별칭 평균)을 갖는 V_GROUPDEPT
CREATE OR REPLACE VIEW V_GROUPDEPT
AS
SELECT DEPT_CODE, SUM(SALARY) 합계, AVG(SALARY) 평균
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT * FROM V_GROUPDEPT;

INSERT INTO V_GROUPDEPT
VALUES('D10', 60000000, 40000000);
-- 오류 보고 - SQL 오류: ORA-01733: virtual column not allowed here
-- 그룹함수 또는 GROUP BY를 사용한 경우 INSERT/UPDATE/DELETE시 에러 발생

UPDATE V_GROUPDEPT
SET DEPT_CODE = 'D10'
WHERE DEPT_CODE = 'D1';
-- 오류 보고 - SQL 오류: ORA-01732: data manipulation operation not legal on this view

DELETE FROM V_GROUPDEPT
WHERE DEPT_CODE = 'D1';
-- 오류 보고 - SQL 오류: ORA-01732: data manipulation operation not legal on this view


-- 5. DISTINCT를 포함한 경우
CREATE OR REPLACE VIEW V_DT_EMP
AS
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT * FROM V_DP_EMP;

INSERT INTO V_DT_EMP 
VALUES ('J9');
-- 오류 보고 - SQL 오류: ORA-01732: data manipulation operation not legal on this view

UPDATE V_DT_EMP
SET JOB_CODE = 'J9'
WHERE JOB_CODE = 'J7';
-- 오류 보고 - SQL 오류: ORA-01732: data manipulation operation not legal on this view

DELETE FROM V_DT_EMP
WHERE JOB_CODE = 'J1';
-- 오류 보고 - SQL 오류: ORA-01732: data manipulation operation not legal on this view

-- 6. JOIN을 이용해 여러 테이블을 연결한 경우
-- V_JOINEMP VIEW에 사번, 이름, 부서 명을 갖게 만들기
CREATE OR REPLACE VIEW V_JOINEMP
AS
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
     
SELECT * FROM V_JOINEMP;

INSERT INTO V_JOINEMP
VALUES (888, '조세오', '인사관리부');
-- 오류 보고 - SQL 오류: ORA-01776: cannot modify more than one base table through a join view
-- JOIN을 통해 베이스 테이블이 1개 이상이 된다면 수정 불가

UPDATE V_JOINEMP
SET DEPT_TITLE = '인사관리부'
WHERE EMP_ID = 219;
-- 오류 보고 - SQL 오류: ORA-01779: cannot modify a column which maps to a non key-preserved table

COMMIT;

DELETE FROM V_JOINEMP
WHERE EMP_ID = 219;

SELECT * FROM V_JOINEMP;
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

ROLLBACK;

SELECT * FROM USER_VIEWS;
-- USER_VIEWS : 사용자 정의 뷰 확인 데이터 딕셔너리(DD)
-- 뷰를 실행할 때 뷰를 정의한 쿼리 문이 텍스트 안에 정의되어 있고, 호출, 삭제, 등등 할 때 그 텍스트를 가져와서 보여주는 것임

-- VIEW 옵션
/*
    CREATE OR REPLACE [FORCE | NOFORCE] VIEW 뷰이름[(ALIAS,[, ALIAS...])]
    AS SUBQUERY;
    [WITH CHECK OPTION]
    [WITH READ ONLY];
*/
-- OR REPLACE : 기존에 동일한 뷰 이름이 존재하는 경우 덮어쓰고, 존재하지 않으면 새로 생성
-- FORCE/NOFORCE
--      FORCE : 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰 생성
--      NOFORCE : 서브쿼리에 사용된 테이블이 존재해야만 뷰 생성(기본 값)
-- WITH CHECK OPTION : 옵션에 설정한 컬럼의 값을 수정 불가능하게 함
-- WITH READ ONLY : 뷰에 대해 조회만 가능

-- OR REPLACE
CREATE OR REPLACE VIEW V_EMP1
AS SELECT EMP_NO, EMP_NAME
   FROM EMPLOYEE;

SELECT * FROM V_EMP1;

CREATE OR REPLACE VIEW V_EMP1
AS SELECT EMP_NO, EMP_NAME, SALARY
   FROM EMPLOYEE;
-- EMP_NO, EMP_NAME만 있었던 V_EMP1에 덮어 씌워진 것

CREATE VIEW V_EMP1
AS SELECT EMP_NO, EMP_NAME
   FROM EMPLOYEE;
-- 오류 보고 - ORA-00955: name is already used by an existing object
-- OR REPLACE가 빠졌기 때문에 그냥 있는지 없는지만 확인함
-- OR REPLACE가 있어야지만 기존에 있으면 수정해줌

-- FORCE/NOFORCE
CREATE OR REPLACE /*NOFORCE*/ VIEW V_EMP2
AS SELECT TCODE, TNAME, TCONTENT
   FROM TT;
-- 오류 보고 - ORA-00942: table or view does not exist
-- TT라는 테이블이 없어서 나는 오류

CREATE OR REPLACE FORCE VIEW V_EMP2
AS SELECT TCODE, TNAME, TCONTENT
   FROM TT;
-- *Action: 경고: 컴파일 오류와 함께 뷰가 생성되었습니다.
-- 에러도 나고 볼 수도 없는데 왜 만드냐 - 가끔 테이블보다 VIEW를 먼저 만들어야 할 때가 있다

SELECT * FROM V_EMP2; -- 볼 수도 없음
SELECT * FROM USER_VIEWS;

-- WITH CHECK OPTION
CREATE OR REPLACE VIEW V_EMP3
AS SELECT *
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D9'
    WITH CHECK OPTION;

SELECT * FROM V_EMP3;

UPDATE V_EMP3
SET DEPT_CODE = 'D1'
WHERE EMP_ID = 200;
-- 오류 보고 - ORA-01402: view WITH CHECK OPTION where-clause violation
-- WHERE DEPT_CODE = 'D9' WITH CHECK OPTION; 설정해놨기 때문에

COMMIT;

-- 수정
UPDATE V_EMP3
SET EMP_NAME = '선동이'
WHERE EMP_ID = 200;
-- 원래 선동일

SELECT * FROM V_EMP3;

-- 추가
INSERT INTO V_EMP3
VALUES (301, '선동일', '611235-1985634', 'sun_di@kh.or.kr', '01099998888', 'D9', 'J2', 'S1', 1000000, NULL, NULL, '21/02/18', NULL, 'N');

--INSERT INTO V_EMP3
--VALUES (301, '선동일', '611235-1985634', 'sun_di@kh.or.kr', '01099998888', 'D1', 'J2', 'S1', 1000000, NULL, NULL, '21/02/18', NULL, 'N');
-- 오류 보고 - ORA-01402: view WITH CHECK OPTION where-clause violation
-- 오류나는 이유 : -- WHERE DEPT_CODE = 'D9' WITH CHECK OPTION; 설정해놨기 때문에

SELECT * FROM V_EMP3;

ROLLBACK;

-- WITH READ ONLY
CREATE OR REPLACE VIEW V_DEPT
AS SELECT * FROM DEPARTMENT
WITH READ ONLY;

SELECT * FROM V_DEPT;

INSERT INTO V_DEPT
VALUES('D10', '해외영업4부', 'L1');
-- 오류 보고 - SQL 오류: ORA-42399: cannot perform a DML operation on a read-only view

UPDATE V_DEPT
SET LOCATION_ID = 'L2'
WHERE DEPT_ID = 'D1';
-- 오류 보고 - SQL 오류: ORA-42399: cannot perform a DML operation on a read-only view

DELETE FROM V_DEPT;
-- 오류 보고 - SQL 오류: ORA-42399: cannot perform a DML operation on a read-only view

COMMIT;
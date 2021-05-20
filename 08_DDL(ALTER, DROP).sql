-- DDL

-- ALTER
-- 컬럼 추가/수정/삭제
-- 컬럼 추가
ALTER TABLE DEPT_COPY
ADD(CNAME VARCHAR2(20));

ALTER TABLE DEPT_COPY
ADD(LNAME VARCHAR2(40) DEFAULT '한국');

SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY
MODIFY DEPT_ID CHAR(3)
MODIFY DEPT_TITLE VARCHAR2(30)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY CNAME CHAR(20)
MODIFY LNAME DEFAULT '미국';

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(10);
-- 오류 보고 - ORA-01441: cannot decrease column length because some value is too big 
-- 기존 데이터의 크기가 더 크다

INSERT INTO DEPT_COPY
VALUES ('D11', '생산부', 'L2', NULL, DEFAULT);

SELECT * FROM DEPT_COPY;

-- 컬럼 삭제
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
DROP COLUMN LOCATION_ID;

ALTER TABLE DEPT_COPY2
DROP COLUMN CNAME;

ALTER TABLE DEPT_COPY2
DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_ID; -- 지우려는 테이블에 최소 한 개 이상의 컬럼이 남아있어야 함

ROLLBACK;

CREATE TABLE TB1(
    PK1 NUMBER PRIMARY KEY,
    COL1 NUMBER,
    CHECK(PK1 > 0 AND COL1 > 0)
);

CREATE TABLE TB2(
    PK2 NUMBER PRIMARY KEY,
    FK2 NUMBER REFERENCES TB1,
    COL2 NUMBER,
    CHECK(PK2 > 0 AND COL2 > 0)
);

ALTER TABLE TB1
DROP COLUMN PK1;
-- 오류 보고 -
-- ORA-12992: cannot drop parent key column
-- 12992. 00000 -  "cannot drop parent key column"
-- *Cause:    An attempt was made to drop a parent key column.
-- *Action:   Drop all constraints referencing the parent key column, or
--           specify CASCADE CONSTRAINTS in statement.

ALTER TABLE TB2
DROP COLUMN PK2;

ALTER TABLE TB1
DROP COLUMN PK1 CASCADE CONSTRAINTS;

-- 제약 조건 추가/삭제
ALTER TABLE DEPT_COPY
ADD CONSTRAINT PK_DCOPY_DID PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT UQ_DCOPY_DTITLE UNIQUE(DEPT_TITLE) -- 빨간줄 편집기 오류
MODIFY LNAME CONSTRAINT NN_DCOPY_LNAME NOT NULL;

ALTER TABLE DEPT_COPY
DROP CONSTRAINT PK_DCOPY_DID;

ALTER TABLE DEPT_COPY
DROP CONSTRAINT UQ_DCOPY_DTITLE
MODIFY LNAME NULL;

-- 컬럼, 제약조건, 테이블 이름 변경
SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY
RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007054 TO NN_UF_UP;

ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007055 TO PK_UF_UNO;

ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007056 TO UQ_UF_UID;

ALTER TABLE DEPT_COPY
RENAME TO DEPT_TEST;

-- 테이블 삭제
DROP TABLE DEPT_TEST;

DROP TABLE DEPT_TEST
CASCADE CONSTRAINTS;

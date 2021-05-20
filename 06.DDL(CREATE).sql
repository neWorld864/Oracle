-- DDL : ������ ���� ���
-- ��ü�� ����� �����ϰ� �����ϴ� ����

-- CREATE : ��ü�� �����ϴ� ����

-- ���̺� �����
CREATE TABLE MEMBER(
--          ���̺��̸�
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20)
);

SELECT * FROM MEMBER;

-- �÷��� �ּ��ޱ�
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�� ���̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ�� ��й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ�� �̸�';

SELECT * FROM USER_TABLES;
-- USER_TABLE : ����ڰ� �ۼ��� ���̺��� Ȯ���ϴ� ��

SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MEMBER';
-- USER_TAB_COLUMNS : ���̺�, ���� �÷��� ���õ� ���� ��ȸ

DESC MEMBER;
--DESC : ���̺� ���� ǥ��

-- ��������
-- ���� ������ ���̺��� ó�� ���� �� �����ص� �ǰ� ���̺��� ����� ���� ���߿� �������൵ ��
SELECT * FROM USER_CONSTRAINTS; -- ����ڰ� �ۼ��� ���������� Ȯ���ϴ� ��
SELECT * FROM USER_CONS_COLUMNS; -- ���������� �ɷ� �ִ� �÷��� Ȯ���ϴ� ��

-- NOT NULL : �ش� �÷��� ���� �ݵ�� ��ϵǾ���ϴ� ��� ���
-- �÷��������� ����
CREATE TABLE USER_NOCONST(
    USER_NO NUMBER, 
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOCONST
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_NOCONST
VALUES(NULL, NULL, NULL, NULL, NULL, '010-2222-3333', 'kang123@kh.or.kr');

SELECT * FROM USER_NOCONST;

CREATE TABLE USER_NOTNULL(
    USER_NO NUMBER NOT NULL, -- �÷��������� �������� ����
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOTNULL
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_NOTNULL
VALUES(NULL, NULL, NULL, NULL, NULL, '010-2222-3333', 'kang123@kh.or.kr');
-- ���� ���� - ORA-01400: cannot insert NULL into ("KH"."USER_NOTNULL"."USER_NO")


-- UNIQUE
-- �÷�����, ���̺� ���� ���� ����
SELECT * FROM USER_NOCONST;

INSERT INTO USER_NOCONST
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

CREATE TABLE USER_UNIQUE(
    USER_NO NUMBER, 
    USER_ID VARCHAR2(20) UNIQUE, -- �÷��������� �������� ����
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_UNIQUE
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');
-- ���� ���� - ORA-00001: unique constraint (KH.SYS_C007038) violated
-- USER_ID�� UNIQUE �������� ���� : �ߺ� �� ��� �� ��

SELECT * FROM USER_UNIQUE;

CREATE TABLE USER_UNIQUE2(
    USER_NO NUMBER, 
    USER_ID VARCHAR2(20) NOT NULL, -- �÷��������� �������� ����
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_ID) -- ���̺� �������� �������� ����
);

INSERT INTO USER_UNIQUE2
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_UNIQUE2
VALUES(1, NULL, 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');
-- ORA-01400: cannot insert NULL into ("KH"."USER_UNIQUE2"."USER_ID")
-- USER ID�� �������� -> NULL�� ������ �� ��

CREATE TABLE USER_UNIQUE3(
    USER_NO NUMBER, 
    USER_ID VARCHAR2(20), 
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_NO, USER_ID)
);

INSERT INTO USER_UNIQUE3
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_UNIQUE3
VALUES(2, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_UNIQUE3
VALUES(2, 'user02', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_UNIQUE3
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');
-- ���� ���� - ORA-00001: unique constraint (KH.SYS_C007043) violated
-- UNIQUE(USER_NO, USER_ID) => USER_NO�� USER_ID�� �ϳ��� ���� ���ϴ� ����. �׷��� user01�� �ߺ� �Ǿ
-- user number�� �ߺ��Ǿ ������ �ߺ��� ���� �ƴϱ� ������ ������ ���� �ʴ´�.

CREATE TABLE CONS_NAME(
    TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_CN_TD1 NOT NULL,
    TEST_DATA2 VARCHAR2(20) CONSTRAINT UQ_CN_TD2 UNIQUE,
    TEST_DATA3 VARCHAR2(20),
    CONSTRAINT UK_CN_TD3 UNIQUE(TEST_DATA3)
);

INSERT INTO CONS_NAME
VALUES('TEST1', 'TEST2', 'TEST3');

-- PRIMARY KEY : NOT NULL + UNIQUE
-- �� ���̺� �� �ϳ��� ���� ����
-- �÷� ����, ���̺� ���� ���� ����

CREATE TABLE USER_PRIMARYKEY(
    USER_NO NUMBER CONSTRAINT PK_UP_UNO PRIMARY KEY, -- �÷� ����
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_PRIMARYKEY
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY
VALUES(1, 'user02', 'pass02', '������', '��', '010-2222-3333', 'nam123@kh.or.kr');
-- ORA-00001: unique constraint (KH.PK_UP_UNO) violated
-- USER_NO�� PRIMARY KEY ���� ���� : NOT NULL + UNIQUE
-- �⺻Ű �ߺ����� ����

INSERT INTO USER_PRIMARYKEY
VALUES(NULL, 'user03', 'pass03', '�����', '��', '010-3333-4444', 'do123@kh.or.kr');
-- ORA-01400: cannot insert NULL into ("KH"."USER_PRIMARYKEY"."USER_NO")
-- �⺻Ű�� NULL�� �����Ƿ� ����

CREATE TABLE USER_PRIMARYKEY2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    CONSTRAINT PK_UP2_UNO_UID PRIMARY KEY(USER_NO, USER_ID) -- ����Ű�� ���̺����� ����
);

SELECT * FROM USER_PRIMARYKEY2;

INSERT INTO USER_PRIMARYKEY2
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES(1, 'user02', 'pass02', '������', '��', '010-2222-3333', 'nam123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES(2, 'user01', 'pass01', '�����', '��', '010-3333-4444', 'do123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES(1, 'user01', 'pass01', '�����', '��', '010-4444-5555', 'ryu123@kh.or.kr');
-- ���� ���� - ORA-00001: unique constraint (KH.PK_UP2_UNO_UID) violated
-- �⺻Ű �ߺ����� ����

INSERT INTO USER_PRIMARYKEY2
VALUES(NULL, 'user01', 'pass01', '�����', '��', '010-4444-5555', 'ryu123@kh.or.kr');
-- ���� ���� - ORA-01400: cannot insert NULL into ("KH"."USER_PRIMARYKEY2"."USER_NO")
-- �⺻Ű�� NULL�� �����Ƿ� ����

-- FOREIGN KEY
-- ������ �ٸ� ���̺��� �����ϴ� ���� ��� ����
-- FOREIGN KEY�������ǿ� ���� ���̺��� ���� ����
-- ���� �Ǵ� �� �ܿ��� NULL �̿� ����
-- ���̺� ����, �÷� ���� ���� ����

CREATE TABLE USER_GRADE(
GRADE_CODE NUMBER PRIMARY KEY,
GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE VALUES(30, 'Ư��ȸ��');

SELECT * FROM USER_GRADE;

CREATE TABLE USER_FOREIGNKEY(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_UF_GC FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE) -- ��� �ִ� ���� �����ؿ��ڴ�
);

INSERT INTO USER_FOREIGNKEY
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY
VALUES(2, 'user02', 'pass02', '������', '��', '010-2222-3333', 'nam123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY
VALUES(3, 'user03', 'pass03', '�����', '��', '010-3333-4444', 'do123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY
VALUES(4, 'user04', 'pass04', '�����', '��', '010-4444-5555', 'ryu123@kh.or.kr', NULL);

SELECT * FROM USER_FOREIGNKEY;

INSERT INTO USER_FOREIGNKEY
VALUES(5, 'user05', 'pass05', '���̹�', '��', '010-5555-6666', 'moon123@kh.or.kr', 50);
-- ���� ���� - ORA-02291: integrity constraint (KH.FK_UF_GC) violated - parent key not found
-- USER GRADE�� 50�̶�� ���� �����Ƿ� ������ ����!!
-- GRADE_NAME VARCHAR2(30) NOT NULL�� �����س���

COMMIT;

DELETE FROM USER_GRADE
WHERE GRADE_CODE = 10;
-- ���� ���� - ORA-02292: integrity constraint (KH.FK_UF_GC) violated - child record found
-- ���� �����ϰ� �ִ� ���̵��� �ִ�, �׷��� ���� �� ����

DELETE FROM USER_GRADE
WHERE GRADE_CODE = 20;
-- 20�� �����ϰ� �ִ� �� ���� ������ ���� ����

ROLLBACK; 
-- DELETE �� �� �ǵ�����

CREATE TABLE USER_GRADE2(
GRADE_CODE NUMBER PRIMARY KEY,
GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE2 VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE2 VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE2 VALUES(30, 'Ư��ȸ��');


CREATE TABLE USER_FOREIGNKEY2(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_UF_GC2 FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE2(GRADE_CODE) ON DELETE SET NULL
    -- ON DELETE SET NULL : �θ� Ű ���� �� �ڽ� Ű�� NULL�� �����ϴ� ���� �ɼ�
);
-- name already used by an existing constraint
-- ���̺� �̸��� �ٸ����� ���� ���Ǹ��� ������ �� �ȴ�
-- CONSTRAINT�̸� �����ϰ� REFERENCES�� USER_GRADE2��


INSERT INTO USER_FOREIGNKEY2
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY2
VALUES(2, 'user02', 'pass02', '������', '��', '010-2222-3333', 'nam123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY2
VALUES(3, 'user03', 'pass03', '�����', '��', '010-3333-4444', 'do123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY2
VALUES(4, 'user04', 'pass04', '�����', '��', '010-4444-5555', 'ryu123@kh.or.kr', NULL);

SELECT * FROM USER_FOREIGNKEY2;

INSERT INTO USER_FOREIGNKEY2
VALUES(5, 'user05', 'pass05', '���̹�', '��', '010-5555-6666', 'moon123@kh.or.kr', 50);
-- ���� ���� - ORA-02291: integrity constraint (KH.FK_UF_GC2) violated - parent key not found

COMMIT;

DELETE FROM USER_GRADE2
WHERE GRADE_CODE = 10;

-----------------------------


CREATE TABLE USER_GRADE3(
GRADE_CODE NUMBER PRIMARY KEY,
GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE3 VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE3 VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE3 VALUES(30, 'Ư��ȸ��');


CREATE TABLE USER_FOREIGNKEY3(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_UF_GC3 FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE3(GRADE_CODE) ON DELETE CASCADE
    -- ON DELETE CASCADE : �θ� Ű ���� �� �ڽ� Ű�� �Բ� �����ϴ� ���� �ɼ�
);

INSERT INTO USER_FOREIGNKEY3
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY3
VALUES(2, 'user02', 'pass02', '������', '��', '010-2222-3333', 'nam123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY3
VALUES(3, 'user03', 'pass03', '�����', '��', '010-3333-4444', 'do123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY3
VALUES(4, 'user04', 'pass04', '�����', '��', '010-4444-5555', 'ryu123@kh.or.kr', NULL);

SELECT * FROM USER_FOREIGNKEY3;

INSERT INTO USER_FOREIGNKEY3
VALUES(5, 'user05', 'pass05', '���̹�', '��', '010-5555-6666', 'moon123@kh.or.kr', 50);

COMMIT;

DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10;
-- �ƿ� 1, 2���� ������(Ȯ���� USER_FOREIGNKEY3�� �����Ϳ���)

-- CHECK
-- ���ϴ� ���̳� �Լ� ��� �� ��
CREATE TABLE USER_CHECK(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10) CHECK(GENDER IN('��', '��')),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_CHECK
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_CHECK
VALUES(2, 'user02', 'pass02', '������', '����', '010-2222-3333', 'nam123@kh.or.kr');
-- ���� ���� - ORA-02290: check constraint (KH.SYS_C007074) violated
-- CHECK(GENDER IN('��', '��')) : '��'�̳� '��'�� ��� �ϴµ� '����'�� �Ἥ ������ ��

CREATE TABLE USER_CHECK2(
    TEST_NUMBER NUMBER,
    CONSTRAINT CK_TEST_NUMBER CHECK(TEST_NUMBER > 0)
);

INSERT INTO USER_CHECK2 VALUES(10);
INSERT INTO USER_CHECK2 VALUES(-10);
-- ���� ���� - ORA-02290: check constraint (KH.CK_TEST_NUMBER) violated
-- (TEST_NUMBER > 0)

CREATE TABLE USER_CHECK3(
    C_NAME VARCHAR2(15 CHAR),
    C_PRICE NUMBER,
    C_LEVEL CHAR(1),
    C_DATE DATE,
    CONSTRAINT PK_UC3_NAME PRIMARY KEY(C_NAME),
--    CONSTRAINT CK_UC3_PRICE CHECK(C_PRICE >= 1 AND C_PRICE <= 99999),
    CONSTRAINT CK_UC3_PRICE CHECK(C_PRICE BETWEEN 1 AND 99999),
    CONSTRAINT CK_UC3_LEVEL CHECK(C_LEVEL = 'A' OR C_LEVEL = 'B' OR C_LEVEL = 'C'),
    CONSTRAINT CK_UC3_DATE CHECK(C_DATE >= TO_DATE('2020/01/01', 'YYYY/MM/DD'))
);

-- �ǽ�����
-- ȸ�� ���Կ� ���̺� ���� : USER_TEST
-- �÷���
-- USER_NO(ȸ�� ��ȣ):NUMBER - �⺻Ű : PK_UT_USERNO
-- USER_ID(ȸ�� ���̵�):VARCHAR2(20) - �ߺ����� : UQ_UT_USERID
-- USER_PWD(ȸ�� ��й�ȣ):VARCHAR2(20) - NULL�� ��� ����(NN_UT_USERPWD)
-- PNO(�ֹε�Ϲ�ȣ):VARCHAR2(20) - �ߺ�����(UQ_UT_PNO), NULL�� ��� ����(NN_UT_PNO)
-- GERDER(����):VARCHAR2(3) - '��' Ȥ�� '��'�� �Է�(CK_UT_GENDER)
-- PHONE(����ó):VARCHAR2(20)
-- ADDRESS(�ּ�):VARCHAR2(100)
-- STATUS(Ż�𿩺�):VARCHAR2(3) - NULL�� ��� ����(NN_UT_STATUS), 'Y' �Ǵ� 'N'���� �Է�(CK_UT_STATUS)
-- �� �÷��� �������ǿ� �̸� �ο��� ��
-- 5�� �̻� INSERT�� ��

CREATE TABLE USER_TEST(
    USER_NO NUMBER CONSTRAINT PK_UT_USERNO PRIMARY KEY,
    USER_ID VARCHAR2(20) CONSTRAINT UQ_UT_USERID UNIQUE,
    USER_PWD VARCHAR2(20) CONSTRAINT NN_UT_USERPWD NOT NULL,
    PNO VARCHAR2(20) CONSTRAINT UQ_UT_PNO NOT NULL,
    GENDER VARCHAR2(3) CONSTRAINT CK_UT_GENDER CHECK(GENDER IN('��', '��')),
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(100),
    STATUS VARCHAR2(3) CONSTRAINT NN_UT_STATUS NOT NULL,
    CONSTRAINT UQ_UT_PNO UNIQUE(PNO),
    CONSTRAINT CK_UT_STATUS CHECK(STATUS IN('Y', 'N'))
); 

COMMENT ON COLUMN USET_TEST.USER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN USET_TEST.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN USET_TEST.USER_PWD IS '��й�ȣ';
COMMENT ON COLUMN USET_TEST.PNO IS '�ֹε�Ϲ�ȣ';
COMMENT ON COLUMN USET_TEST.GENDER IS '����';
COMMENT ON COLUMN USET_TEST.PHONE IS '����ó';
COMMENT ON COLUMN USET_TEST.ADDRESS IS '�ּ�';
COMMENT ON COLUMN USET_TEST.STATUS IS 'Ż�𿩺�';


INSERT INTO USER_TEST
VALUES(1, 'user01', 'pass01', '941026-1452698', '��', '010-1111-2222', '����� ���ı� ��ǵ�', 'Y');

INSERT INTO USER_TEST
VALUES(2, 'user02', 'pass02', '780804-2356348', '��', '010-2222-3333', '��⵵ ���� �ϻ굿��', 'N');

INSERT INTO USER_TEST
VALUES(3, 'user04', 'pass03', '980628-2256451', '��', '010-4444-5555', '��õ�� ������ �۵���', 'N');

INSERT INTO USER_TEST
VALUES(4, 'user03', 'pass05', '001118-1245621', '��', '010-3333-4444', '����� ��걸 �ѳ���', 'N');

INSERT INTO USER_TEST
VALUES(5, 'user05', 'pass01', '890309-2101854', '��', '010-5555-6666', '��⵵ ������ �д籸', 'N');

DELETE FROM USER_TEST
WHERE USER_ID = 'user05';

SELECT * FROM USER_TEST;

COMMIT;

-- SUBQUERY�� �̿��� ���̺� ����
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY;

CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, JOB_NAME
   FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        JOIN JOB USING(JOB_CODE);

SELECT * FROM EMPLOYEE_COPY2;

CREATE TABLE USER_GRADE4(
    GRADE_CODE NUMBER,
    GRADE_NAME VARCHAR2(30)
);

-- ���̺� ���� : ALTER
-- ALTER TABLE ���̺�� ADD ������������(�÷���) [REFERENCES ���̺��(�÷���)];
-- ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL;
ALTER TABLE USER_GRADE4 ADD PRIMARY KEY(GRADE_CODE);

CREATE TABLE USER_FOREIGNKEY4(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20), -- UNIQUE
    USER_PWD VARCHAR2(30) NOT NULL, -- NOT NULL
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10), -- CHECK
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER -- FOREIGN KEY
);

ALTER TABLE USER_FOREIGNKEY4 ADD UNIQUE(USER_ID);
ALTER TABLE USER_FOREIGNKEY4 ADD CHECK(GENDER IN ('��', '��'));
ALTER TABLE USER_FOREIGNKEY4 ADD FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE4; -- USER_GRADE4 ���̺��� �⺻Ű ����
-- = ALTER TABLE USER_FOREIGNKEY4 ADD FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE4(GRADE_CODE);

-- DEPARTMENT���̺��� LOCATION_ID�� �ܷ�Ű �������� �߰�
-- ���� ���̺��� LOCATION, ���� �÷��� LOCATION�� �⺻ Ű
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;

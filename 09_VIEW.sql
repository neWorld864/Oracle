-- VIEW
-- SELECT ���� ���� ��� ȭ���� ������ ��ü, ������ ���� ���̺�
-- ���� �����͸� �����ϰ� �ִ� ���� �ƴ����� �Ϲ� ���̺��� ����ϴ� �Ͱ� �����ϰ� �� �� ����
-- CREATE [OR REPLACE] VIEW ���̸� AS ��������;
-- OR REPLACE �ɼ� : �� ���� �� ������ ���� �̸��� �䰡 �ִٸ� �ش� �並 ����
-- OR REPLACE �ɼ��� ������� �ʰ� ���� �̸��� �� ���� �� �̹� �ٸ� ��ü�� ��� ���� �̸��̶�� ���� �߻�

-- ���, �̸�, �μ���, �ٹ������� ��ȸ�ϰ� �� ����� V_EMPLOYEE��� �並 �����ؼ� ����
CREATE OR REPLACE VIEW V_EMPLOYEE
AS
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
     LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
     LEFT JOIN NATIONAL USING (NATIONAL_CODE);
-- ���� ���� - ORA-01031: insufficient privileges
-- 01031. 00000 -  "insufficient privileges" 
-- KH������ VIEW�� ���� �� �ִ� ������ ���� -> SYSTEM������ ������ �� �� �ִ� -> SYSTEM�������� ��ȯ �� ������ �ִ� ��ɾ� GRANT

-- �ý��� �������� ���� �� VIEW ���� ������ KH������ �ο�
GRANT CREATE VIEW TO KH;
-- GRANT��(��) �����߽��ϴ�.�� �߸� �ٽ� KH ���� ���� �� �� VIEW���� ���� ����
-- View V_EMPLOYEE��(��) �����Ǿ����ϴ�.

SELECT * FROM V_EMPLOYEE;

COMMIT;

SELECT * 
FROM EMPLOYEE
WHERE EMP_ID = 205;
-- ������

-- ����� 205���� ����� �̸��� ���߾����� ����
UPDATE EMPLOYEE
SET EMP_NAME = '���߾�'
WHERE EMP_ID = 205;
-- ���̽� ���̺��� ������ ����Ǹ� VIEW�� ���� ��

ROLLBACK;

-- ���, �̸�, ���� ��, ����, �ٹ���� ��ȸ
-- V_EMP_JOB VIEW�� ��� ����
CREATE OR REPLACE VIEW V_EMP_JOB(���, �̸�, ����, ����, �ٹ����)
AS
SELECT EMP_ID, EMP_NAME, JOB_NAME,
       DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', '��'),
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE);
-- ���� ���� - ORA-00998: must name this expression with a column alias
-- ���������� �ִ� �Լ� ������ �� ��Ī�� �־���� �Ѵ�
-- ��Ī ����ó�� �Է��ص� ��� ����

SELECT * FROM V_EMP_JOB;

-- �並 �̿��Ͽ� DML ��� ����
-- �����ڵ�, ���� ���� ���� �ִ� VIEW V_JOB ����
CREATE OR REPLACE VIEW V_JOB
AS
SELECT JOB_CODE, JOB_NAME
FROM JOB;

SELECT * FROM JOB;
SELECT * FROM V_JOB;

INSERT INTO V_JOB VALUES('J8', '����');
-- �信�� ��û�� DML���� ���̽� ���̺� ����

UPDATE V_JOB
SET JOB_NAME = '�˹�'
WHERE JOB_CODE = 'J8';

DELETE FROM V_JOB
WHERE JOB_CODE = 'J8'; -- ���̺�� �䰡 �Բ� ����??

-- DML ��ɾ�� ������ �Ұ����� ���
-- 1. �� ���ǿ� ���Ե��� ���� �÷��� �����ϴ� ���
-- 2. �信 ���Ե��� ���� �÷� �߿� ���̽��� �Ǵ� �÷��� NOT NULL ���������� ������ ���
-- 3. ��� ǥ�������� ���ǵ� ���
-- 4. �׷��Լ��� GROUP BY���� ������ ���
-- 5. DISTINCT�� ������ ���
-- 6. JOIN�� �̿��� ���� ���̺��� ������ ���

-- 1. �� ���ǿ� ���Ե��� ���� �÷��� �����ϴ� ���
CREATE OR REPLACE VIEW V_JOB2
AS SELECT JOB_CODE
   FROM JOB;

SELECT * FROM V_JOB2;

INSERT INTO V_JOB2 VALUES ('J8', '����');
-- ���� ���� - SQL ����: ORA-00942: table or view does not exist
-- V_JOB2���� JOB_CODE�� �ִµ� JOB_NAME���� �����ϱ� ����

UPDATE V_JOB2
SET JOB_NAME = '����'
WHERE JOB_CODE = 'J7';
-- ���� ���� - SQL ����: ORA-00942: table or view does not exist

DELETE FROM V_JOB2
WHERE JOB_NAME = '���';
-- ���� ���� - SQL ����: ORA-00942: table or view does not exist

-- 2. �信 ���Ե��� ���� �÷� �߿�, ���̽� ���̺� �÷��� NOT NULL ���������� ������ ���
CREATE OR REPLACE VIEW V_JOB3
AS SELECT JOB_NAME
   FROM JOB;

INSERT INTO V_JOB3 VALUES('����');
-- ���� ���� - ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")

SELECT * FROM V_JOB3;

UPDATE V_JOB3
SET JOB_NAME = '�˹�'
WHERE JOB_NAME = '����';

DELETE FROM V_JOB3
WHERE JOB_NAME = '����';


-- 3. ��� ǥ�������� ���ǵ� ���
CREATE OR REPLACE VIEW EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY,
          (SALARY + (SALARY*NVL(BONUS, 0)))*12 ����
   FROM EMPLOYEE;

SELECT * FROM EMP_SAL;

INSERT INTO EMP_SAL
VALUES (800, '������', 3000000, 360000000);
-- ���� ���� - SQL ����: ORA-01733: virtual column not allowed here
-- ���� �÷��� ������� �ʴ´�

UPDATE EMP_SAL
SET ���� = 100
WHERE EMP_ID = 200;
-- ���� ���� - SQL ����: ORA-01733: virtual column not allowed here

COMMIT;

DELETE FROM EMP_SAL
WHERE ���� = 124800000;

SELECT * FROM EMP_SAL;
SELECT * FROM EMPLOYEE;

ROLLBACK;

-- 4. �׷��Լ��� GROUP BY���� ������ ���
-- �μ� �ڵ�, �μ� �� �޿� �հ�(��Ī �հ�), �μ� �� �޿� ���(��Ī ���)�� ���� V_GROUPDEPT
CREATE OR REPLACE VIEW V_GROUPDEPT
AS
SELECT DEPT_CODE, SUM(SALARY) �հ�, AVG(SALARY) ���
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT * FROM V_GROUPDEPT;

INSERT INTO V_GROUPDEPT
VALUES('D10', 60000000, 40000000);
-- ���� ���� - SQL ����: ORA-01733: virtual column not allowed here
-- �׷��Լ� �Ǵ� GROUP BY�� ����� ��� INSERT/UPDATE/DELETE�� ���� �߻�

UPDATE V_GROUPDEPT
SET DEPT_CODE = 'D10'
WHERE DEPT_CODE = 'D1';
-- ���� ���� - SQL ����: ORA-01732: data manipulation operation not legal on this view

DELETE FROM V_GROUPDEPT
WHERE DEPT_CODE = 'D1';
-- ���� ���� - SQL ����: ORA-01732: data manipulation operation not legal on this view


-- 5. DISTINCT�� ������ ���
CREATE OR REPLACE VIEW V_DT_EMP
AS
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT * FROM V_DP_EMP;

INSERT INTO V_DT_EMP 
VALUES ('J9');
-- ���� ���� - SQL ����: ORA-01732: data manipulation operation not legal on this view

UPDATE V_DT_EMP
SET JOB_CODE = 'J9'
WHERE JOB_CODE = 'J7';
-- ���� ���� - SQL ����: ORA-01732: data manipulation operation not legal on this view

DELETE FROM V_DT_EMP
WHERE JOB_CODE = 'J1';
-- ���� ���� - SQL ����: ORA-01732: data manipulation operation not legal on this view

-- 6. JOIN�� �̿��� ���� ���̺��� ������ ���
-- V_JOINEMP VIEW�� ���, �̸�, �μ� ���� ���� �����
CREATE OR REPLACE VIEW V_JOINEMP
AS
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
     
SELECT * FROM V_JOINEMP;

INSERT INTO V_JOINEMP
VALUES (888, '������', '�λ������');
-- ���� ���� - SQL ����: ORA-01776: cannot modify more than one base table through a join view
-- JOIN�� ���� ���̽� ���̺��� 1�� �̻��� �ȴٸ� ���� �Ұ�

UPDATE V_JOINEMP
SET DEPT_TITLE = '�λ������'
WHERE EMP_ID = 219;
-- ���� ���� - SQL ����: ORA-01779: cannot modify a column which maps to a non key-preserved table

COMMIT;

DELETE FROM V_JOINEMP
WHERE EMP_ID = 219;

SELECT * FROM V_JOINEMP;
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

ROLLBACK;

SELECT * FROM USER_VIEWS;
-- USER_VIEWS : ����� ���� �� Ȯ�� ������ ��ųʸ�(DD)
-- �並 ������ �� �並 ������ ���� ���� �ؽ�Ʈ �ȿ� ���ǵǾ� �ְ�, ȣ��, ����, ��� �� �� �� �ؽ�Ʈ�� �����ͼ� �����ִ� ����

-- VIEW �ɼ�
/*
    CREATE OR REPLACE [FORCE | NOFORCE] VIEW ���̸�[(ALIAS,[, ALIAS...])]
    AS SUBQUERY;
    [WITH CHECK OPTION]
    [WITH READ ONLY];
*/
-- OR REPLACE : ������ ������ �� �̸��� �����ϴ� ��� �����, �������� ������ ���� ����
-- FORCE/NOFORCE
--      FORCE : ���������� ���� ���̺��� �������� �ʾƵ� �� ����
--      NOFORCE : ���������� ���� ���̺��� �����ؾ߸� �� ����(�⺻ ��)
-- WITH CHECK OPTION : �ɼǿ� ������ �÷��� ���� ���� �Ұ����ϰ� ��
-- WITH READ ONLY : �信 ���� ��ȸ�� ����

-- OR REPLACE
CREATE OR REPLACE VIEW V_EMP1
AS SELECT EMP_NO, EMP_NAME
   FROM EMPLOYEE;

SELECT * FROM V_EMP1;

CREATE OR REPLACE VIEW V_EMP1
AS SELECT EMP_NO, EMP_NAME, SALARY
   FROM EMPLOYEE;
-- EMP_NO, EMP_NAME�� �־��� V_EMP1�� ���� ������ ��

CREATE VIEW V_EMP1
AS SELECT EMP_NO, EMP_NAME
   FROM EMPLOYEE;
-- ���� ���� - ORA-00955: name is already used by an existing object
-- OR REPLACE�� ������ ������ �׳� �ִ��� �������� Ȯ����
-- OR REPLACE�� �־������ ������ ������ ��������

-- FORCE/NOFORCE
CREATE OR REPLACE /*NOFORCE*/ VIEW V_EMP2
AS SELECT TCODE, TNAME, TCONTENT
   FROM TT;
-- ���� ���� - ORA-00942: table or view does not exist
-- TT��� ���̺��� ��� ���� ����

CREATE OR REPLACE FORCE VIEW V_EMP2
AS SELECT TCODE, TNAME, TCONTENT
   FROM TT;
-- *Action: ���: ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.
-- ������ ���� �� ���� ���µ� �� ����� - ���� ���̺��� VIEW�� ���� ������ �� ���� �ִ�

SELECT * FROM V_EMP2; -- �� ���� ����
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
-- ���� ���� - ORA-01402: view WITH CHECK OPTION where-clause violation
-- WHERE DEPT_CODE = 'D9' WITH CHECK OPTION; �����س��� ������

COMMIT;

-- ����
UPDATE V_EMP3
SET EMP_NAME = '������'
WHERE EMP_ID = 200;
-- ���� ������

SELECT * FROM V_EMP3;

-- �߰�
INSERT INTO V_EMP3
VALUES (301, '������', '611235-1985634', 'sun_di@kh.or.kr', '01099998888', 'D9', 'J2', 'S1', 1000000, NULL, NULL, '21/02/18', NULL, 'N');

--INSERT INTO V_EMP3
--VALUES (301, '������', '611235-1985634', 'sun_di@kh.or.kr', '01099998888', 'D1', 'J2', 'S1', 1000000, NULL, NULL, '21/02/18', NULL, 'N');
-- ���� ���� - ORA-01402: view WITH CHECK OPTION where-clause violation
-- �������� ���� : -- WHERE DEPT_CODE = 'D9' WITH CHECK OPTION; �����س��� ������

SELECT * FROM V_EMP3;

ROLLBACK;

-- WITH READ ONLY
CREATE OR REPLACE VIEW V_DEPT
AS SELECT * FROM DEPARTMENT
WITH READ ONLY;

SELECT * FROM V_DEPT;

INSERT INTO V_DEPT
VALUES('D10', '�ؿܿ���4��', 'L1');
-- ���� ���� - SQL ����: ORA-42399: cannot perform a DML operation on a read-only view

UPDATE V_DEPT
SET LOCATION_ID = 'L2'
WHERE DEPT_ID = 'D1';
-- ���� ���� - SQL ����: ORA-42399: cannot perform a DML operation on a read-only view

DELETE FROM V_DEPT;
-- ���� ���� - SQL ����: ORA-42399: cannot perform a DML operation on a read-only view

COMMIT;
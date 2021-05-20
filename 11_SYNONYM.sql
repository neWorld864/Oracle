-- SYNONYM : ���Ǿ�

-- ����� ���Ǿ�
--CREATE SYNONYM EMP FOR EMPLOYEE;
-- ���� ���� - ORA-01031: insufficient privileges ������ ���� (LIKE VIEW)

GRANT CREATE SYNONYM TO KH; -- SYSTEM�������� ��ȯ �� ���� �ְ� �ٽ� ���� ����

-- EMPLOYEE ����
CREATE SYNONYM EMP FOR EMPLOYEE;

SELECT * FROM EMPLOYEE;
SELECT * FROM EMP;



-- ���� ���Ǿ�
CREATE PUBLIC SYNONYM DEPT FOR KH.DEPARTMENT;
SELECT * FROM DEPT;

SELECT * FROM KH.EMPLOYEE;
SELECT * FROM KH.EMP;
SELECT * FROM KH.DEPARTMENT;

-- ���Ǿ� ����
-- EMPLOYEE ����
DROP SYNONYM EMP;

SELECT * FROM EMP;

-- SYSTEM ����
DROP PUBLIC SYNONYM DEPT;

SELECT * FROM DEPT;

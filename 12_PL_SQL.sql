-- PL/SQL : ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���
-- ����� : DECLARE�� ����, ����, ����� �����ϴ� �κ�
-- ����� : BEGIN���� ����, ���ǹ�, �ݺ���, �Լ� ���� �� ���� ���
-- ����ó���� : EXCEPTION���� ����, ���� �߻� �� �ذ��ϱ� ���� ���� ���

/*
    System.out.println("Hello World");
*/
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;
/ 
/*�� �����ø� ���� PL/SQL�� ���������� ����*/

SET SERVEROUTPUT ON;
-- ���ν����� ����Ͽ� ����ϴ� ������ ȭ�鿡 �����ֵ��� �����ϴ� ȯ�溯���� 
-- �⺻ ���� OFF���� ON���� ����

/*  �ڹ�
    int empId
    String empName;
    final int PI = 3.14;
    
    empId = 888;
    empName = '������';
    
    System.out.println("empId : " + empId);
    System.out.println("empName : " + empName);
    System.out.println("PI : " + PI);
*/
DECLARE
    EMP_ID NUMBER;         -- NUMBERŸ�� ���� EMP_ID ����
    EMP_NAME VARCHAR2(30); -- VARCHAR2Ÿ�� ���� EMP_NAME ����
    PI CONSTANT NUMBER := 3.14; -- NUMBERŸ�� ��� PI ���� �� �ʱ�ȭ : := ���� ������
BEGIN
    EMP_ID := 888;
    EMP_NAME := '������';
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME -- �÷�(EMPLOYEE ���̺� �ȿ� �ִ� �÷�)
    INTO EMP_ID, EMP_NAME -- ������ ������ �ʵ�
    FROM EMPLOYEE 
    WHERE EMP_ID = 200; -- �÷��� �ִ� EMP_ID
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
END;
/

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME 
    INTO EMP_ID, EMP_NAME 
    FROM EMPLOYEE 
--    WHERE EMP_ID = '&EMP_ID'; 
    WHERE EMP_ID = '&���'; -- ����̶�� �ص� ���� ���� ���´�, ����� �ȳ������� ��� ���� ���� ��
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
END;
/

-- ���۷��� ������ EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY�� �����ϰ�
-- EMPLOYEE���̺��� ���, �̸�, �����ڵ�, �μ��ڵ�, �޿� ��ȸ �� ������ ���۷��� ������ ��� ���
-- ��, �Է� ���� �̸��� ��ġ�ϴ� ������ ��� ��ȸ
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE; -- �ű��ִ� �ָ� �����ؿ��ڴ�
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    INTO EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    FROM EMPLOYEE 
    WHERE EMP_NAME = '&�̸�'; 
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('DEPT_CODE : ' || DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('JOB_CODE : ' || JOB_CODE);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
END;
/

DECLARE
--      EMP_NAME EMPLOYEE.EMP_NAME%TYPE
    E EMPLOYEE%ROWTYPE; -- �� ��ü�� ������
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('EMP_NO : ' || E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || E.SALARY);
END;
/

-- ���ǹ�
-- IF ~ THEN ~ END IF (���� IF��)
-- EMP_ID�� �Է� �޾� �ش� ����� ���, �̸�, �޿�, ���ʽ��� ���
-- ��, ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�.' ���
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    INTO EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    -- IF(BONUS IS NULL)
    IF(BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
    
    
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS * 100 || '%');
END;
/
--210223
-- IF ~ THEN ~ ELSE ~ END IF (IF ~ ELSE��)
-- EMP_ID�� �Է¹޾� �ش� ����� ���, �̸�, �μ���, �Ҽ� ���
-- TEAM������ ����� �Ҽ��� 'KO'�� ����� '������', �ƴ� ����� '�ؿ���'���� ����
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE; 
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NATIONAL_CODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(20);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    FROM EMPLOYEE
         LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
         LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = '&���'; 
    
    IF(NATIONAL_CODE = 'KO') THEN TEAM := '������';
    ELSE TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);

END;
/
-- �׻� SET SERVEROUTPUT ON;�� �ϰ� �����ؾ� �Ѵ�!!! ¯ �߿�


-- ����� ������ ���ϴ� PL/SQL �� �ۼ�
-- ���ʽ��� �ִ� ����� ���ʽ��� �����Ͽ� ���
-- ����ڿ��� ����� �޾ƿ� �� ����� ��ü ������ VEMP�� ���� ��
-- VEMP�� �̿��Ͽ� ���� ���
-- ������ ����� ��� ���� YSALARY�� ����
-- '�޿� �̸� ����(\1,000,000 ����)'�� ���
DECLARE
    VEMP EMPLOYEE%ROWTYPE; 
    YSALARY NUMBER;
BEGIN
    SELECT *
    INTO VEMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&ID';
    
    IF(VEMP.BONUS IS NULL) THEN YSALARY := VEMP.SALARY * 12;
    ELSE YSALARY := VEMP.SALARY * (1 + VEMP.BONUS) * 12;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.SALARY || ' ' || VEMP.EMP_NAME || ' ' || TO_CHAR(YSALARY, 'FML999,999,999'));
    
END;
/

-- IF ~ THEN ~ ELSIF ~ THEN ~ ELSE ~ END IF (IF ~ ELSE IF ~ ELSE��)
-- ������ �Է� �޾� SCORE������ �����ϰ�
-- 90�� �̻��� 'A', 80�� �̻��� 'B', 70�� �̻��� 'C'
-- 60�� �̻��� 'D', 60�� �̸��� 'F'�� ó���Ͽ� GRADE������ ����
-- ����� ������ 90���̰�, ������ A�����Դϴ�. ���·� ���

DECLARE
    SCORE NUMBER; -- ���� ���·� ����Ǵ� ����
    GRADE VARCHAR2(2); -- ���� ���·� ����Ǵ� ����
BEGIN
    SCORE := '&����';
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;

    DBMS_OUTPUT.PUT_LINE('����� ������ ' || SCORE || '���̰�, ������ ' || GRADE || '�����Դϴ�.');
    
END;
/

-- CASE ~ WHEN ~ THEN ~ END(SWITCH ~ CASE��)
-- ��� ��ȣ�� �Է��Ͽ� �ش� ����� ���, �̸�, �μ��� ���
-- IF ��� ��
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&ID';

    IF EMP.DEPT_CODE = 'D1' THEN DNAME := '�λ������';
    ELSIF EMP.DEPT_CODE = 'D2' THEN DNAME := 'ȸ�������';
    ELSIF EMP.DEPT_CODE = 'D3' THEN DNAME := '�����ú�';
    ELSIF EMP.DEPT_CODE = 'D4' THEN DNAME := '����������';
    ELSIF EMP.DEPT_CODE = 'D5' THEN DNAME := '�ؿܿ���1��';
    ELSIF EMP.DEPT_CODE = 'D6' THEN DNAME := '�ؿܿ���2��';
    ELSIF EMP.DEPT_CODE = 'D7' THEN DNAME := '�ؿܿ���3��';
    ELSIF EMP.DEPT_CODE = 'D8' THEN DNAME := '���������';
    ELSIF EMP.DEPT_CODE = 'D9' THEN DNAME := '�ѹ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���  �̸�  �μ���');
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID || ' ' || EMP.EMP_NAME || ' ' || DNAME);
END;
/

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&ID';
    
    DNAME := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '�λ������'
                WHEN 'D2' THEN 'ȸ�������'
                WHEN 'D3' THEN '�����ú�'
                WHEN 'D4' THEN '����������'
                WHEN 'D5' THEN '�ؿܿ���1��'
                WHEN 'D6' THEN '�ؿܿ���2��'
                WHEN 'D7' THEN '�ؿܿ���3��'
                WHEN 'D8' THEN '���������'
                WHEN 'D9' THEN '�ѹ���'
            END;
            
    DBMS_OUTPUT.PUT_LINE('���  �̸�  �μ���');
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID || ' ' || EMP.EMP_NAME || ' ' || DNAME);
END;
/

-- �ݺ���
-- BASIC LOOP : ���ο� ó������ �ۼ��ϰ� �������� LOOP���� ��� ���� ���
/*
    LOOP
        ó����
        ���ǹ�
    END LOOP;
    
    ���ǹ� : IF ���ǽ� THEN EXIT; END IF;
            EXIT WHEN ���ǽ�;
*/

-- 1 ~ 5���� ������ ���
DECLARE
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N + 1;
    -- ���1
--      IF(N > 5) THEN EXIT;
--      END IF;
    -- ���2 
        EXIT WHEN N > 5;
    END LOOP;
END;
/


-- FOR LOOP

/*
    FOR �ε��� IN [REVERSE] �ʱⰪ..������
    LOOP
        ó����
    END LOOP;
*/
-- 1 ~ 5���� ������� ���
BEGIN
    FOR N IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- 1 ~ 5���� �Ųٷ� ���
BEGIN
--    FOR N IN 5..1
    FOR N IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- �̰� ���� �ٽ� ���� 0223 4����
--BEGIN
--    FOR N IN 1..10
--    LOOP
--        INSERT INTO TEST1 VALUES(I, SYSDATE);
--    END LOOP;
--END;
--/
--
--SELECT * FROM TEST1;

-- ��ø �ݺ���
-- ������ ¦���� ����ϱ�

DECLARE
    RESULT NUMBER;
BEGIN
    FOR DAN IN 2..9
    LOOP
        IF MOD(DAN, 2) = 0
            THEN
                FOR SU IN 1..9
                LOOP
                    RESULT := DAN * SU;
                    DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || SU || ' = ' || RESULT);
                END LOOP;
            DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
    END LOOP;
END;
/

-- WHILE LOOP
/*
    WHILE ����
    LOOP
        ó����
    END LOOP;
*/
-- 1 ~5 ������� ���
DECLARE
    N NUMBER := 1;
BEGIN
    WHILE N <= 5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- WHILE������ ������ ¦���� ���
DECLARE
    RESULT NUMBER;
    DAN NUMBER := 2;
    SU NUMBER;
BEGIN
    WHILE DAN <= 9
    LOOP
        SU := 1;
        IF MOD(DAN, 2) = 0
            THEN
                WHILE SU <= 9
                LOOP
                    RESULT := DAN * SU;
                    DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || SU || ' = ' || RESULT);
                    SU := SU + 1;
                END LOOP;
            DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
        DAN := DAN + 1;
    END LOOP;
END;
/

-- EXCEPTION
-- �̸� ���ǵ� ���� ����
-- NO_DATA_FOUND : SELECT���� �ƹ��� ������ ���� ��ȯ���� �� �� ��
-- DUP_VAL_ON_INDEX : UNIQUE������ ���� �÷��� �ߺ��Ǵ� �����Ͱ� �� ��
-- ZERO_DIVIDE : 0���� ���� ��
-- INVALID_CURSOR : �߸��� Ŀ�� ����
-- ��...

BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&���'
    WHERE EMP_ID = 200;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX
    THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�');
END;
/

DECLARE
    NAME VARCHAR2(30);
BEGIN
    SELECT EMP_NAME
    INTO NAME
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('��ȸ ����� �����ϴ�.');
END;
/

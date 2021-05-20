-- ���ν��� : PL/SQL���� �����ϴ� ��ü
-- �ʿ��� ������ �ٽ� �� �ʿ� ���� ������ ȣ���ؼ� ���� ����� ���� �� ����
-- (*) Ư�� ������ ó���ϱ⸸ �ϰ� ��� ���� ��ȯ���� ����
/*
    == ���ν��� ���� ��� ==
    CREATE OR REPLACE PROCEDURE ���ν�����
        (�Ű�������1 [IN | OUT | IN OUT] ������Ÿ��[:= DEFAULT��],
         �Ű�������2 [IN | OUT | IN OUT] ������Ÿ��[:= DEFAULT��],
         ....
         )
    IS
        �����
    BEGIN 
        �����
    EXCEPTION
        ����ó����
    END;
    /
    
    == ���ν��� ȣ�� ��� ==
    EXECUTE ���ν�����;
    EXEC ���ν�����;
*/

CREATE TABLE EMP_DUP
AS SELECT * FROM EMPLOYEE;

CREATE OR REPLACE PROCEDURE DEL_ALL_EMP
IS
BEGIN
    DELETE FROM EMP_DUP;
    COMMIT;
END;
/
-- Procedure DEL_ALL_EMP��(��) �����ϵǾ����ϴ�.

EXECUTE DEL_ALL_EMP;
EXEC DEL_ALL_EMP;

SELECT * FROM EMP_DUP;

-- �Ű����� �ִ� PROCEDURE
CREATE OR REPLACE PROCEDURE DEL_EMP_ID(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
IS
BEGIN
    DELETE FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    --     ����         ��
END;
/

--EXECUTE DEL_EMP_ID;
-- PLS-00306: wrong number or types of arguments in call to 'DEL_EMP_ID' -> �Ű����� ���� �־�� ��

--EXECUTE DEL_EMP_ID(200);
EXEC DEL_EMP_ID('&ID');

SELECT * FROM EMPLOYEE;

ROLLBACK;

-- 210224
-- IN �Ű����� : ���ν��� ���ο��� ���Ǵ� ����
-- OUT �Ű����� : ���ν��� �ܺ�(ȣ���)���� ���Ǵ� ����
-- ����ڰ� �Է��� ������� �̸�, �޿�, ���ʽ� ��ȸ�ϴ� SELECT_EMP_ID���ν��� ����
CREATE OR REPLACE PROCEDURE SELECT_EMP_ID(
    V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
    V_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    V_SALARY OUT EMPLOYEE.SALARY%TYPE,
    V_BONUS OUT EMPLOYEE.BONUS%TYPE
-- �ۿ��� ���ű� ������ OUT����
)
IS
BEGIN
    SELECT EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO V_EMP_NAME, V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
END;
/
-- Procedure SELECT_EMP_ID��(��) �����ϵǾ����ϴ�.

-- ���ε� ���� : SQL�� ���� ������ �� �ִ� ��� ������ ����
VARIABLE VAR_EMP_NAME VARCHAR2(30);
VAR VAR_SALARY NUMBER;
VAR VAR_BONUS NUMBER;

-- PRINT : ������ ������ ������ִ� ��ɾ�
PRINT VAR_EMP_NAME;
PRINT VAR_SALARY;
PRINT VAR_BONUS;
-- ���� �Է� ���� �����Ƿ� �ƹ� ���� ������ �ʴ´�!

EXEC SELECT_EMP_ID('&���', :VAR_EMP_NAME, :VAR_SALARY, :VAR_BONUS);
-- ���ε� ������ ':������'���·� ���� ����
-- �� ���ε� ������ ���� �� ���� �� -> PRINT �ٽ� ����ϸ� ���� ���´�

SET AUTOPRINT ON;
-- ���ε� ������ ���� �ڵ����� ���
-- �̰� �ϰ� EXEC �ٷ� �����ϸ� ��. PRINT ���� ����� �ʿ� ����

-- FUNCTION : ���ν����� �뵵�� ���� ��������� RETURN���� �ִٴ� ���� �ٸ�
/*
    CREATE OR REPLACE FUNCTION �Լ���(�Ű������� �Ű�����Ÿ��, ...)
    RETURN ������Ÿ��
    IS
        �����
    BEGIN
        �����
        RETURN ��ȯ��;
    EXCEPTION
        ����ó����
    END;
    /
*/

-- ����� �Է¹޾� �ش� ����� ������ ����ϰ� �����ϴ� �Լ� ���� : BONUS_CALC
CREATE OR REPLACE FUNCTION BONUS_CALC(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
RETURN NUMBER
IS
    CALC_SAL NUMBER;
    V_SAL EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT SALARY, NVL(BONUS, 0) B
    INTO V_SAL, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    
    CALC_SAL := (V_SAL + (V_SAL * V_BONUS)) * 12;
    
    RETURN CALC_SAL;
END;
/

VAR VAR_CALC NUMBER;

EXEC :VAR_CALC := BONUS_CALC('&ID');

SELECT EMP_ID, EMP_NAME, BONUS_CALC(EMP_ID)
FROM EMPLOYEE
WHERE BONUS_CALC(EMP_ID) > 30000000;
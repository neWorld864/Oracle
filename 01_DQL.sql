-- SELECT
-- RESULT SET : SELECT�������� �����͸� ��ȸ�� �����(��ȯ�� ����� ����)

-- EMPLOYEE ���̺��� ���, �̸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;
-- ��ҹ��� ���� �� �� cf) ���ͷ��� ��й�ȣ�� �빮�ڸ�

-- EMPLOYEE���̺��� ��� ���� ��ȸ
-- ��� 1
SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, DEPT_CODE, JOB_CODE, SAL_LEVEL, 
        SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN
FROM EMPLOYEE;

-- ��� 2
SELECT *
FROM EMPLOYEE;


-------------- �ǽ����� --------------
-- 1. JOB���̺��� ��� ���� ��ȸ
SELECT *
FROM JOB;

-- 2. JOB���̺��� �����̸� ��ȸ
SELECT JOB_NAME
FROM JOB;

-- 3. DEPARTMENT ���̺��� ��� ���� ��ȸ
SELECT *
FROM DEPARTMENT;

-- 4. EMPLOYEE���̺��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- 5. EMPLOYEE���̺��� �����, ��� �̸�, ���� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

-- �÷� �� ��� ����
-- ����Ʈ �� �÷� �� �Է� �κп� ��꿡 �ʿ��� �÷� ��, ����, �����ڸ� �̿��Ͽ� ����� ��ȸ�� �� ����
-- EMPLOYEE  ���̺��� ���� ��, ���� ��ȸ
SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE���̺� ������ ���� ��, ����, ���ʽ��� �߰��� ���� ��ȸ
SELECT EMP_NAME, SALARY*12, (SALARY + (SALARY*BONUS))*12
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY*12, (SALARY*(1+BONUS))*12
FROM EMPLOYEE;

----------- �ǽ����� -----------
-- 1. EMPLOYEE���̺��� �̸�, ����, �Ѽ��ɿ�(���ʽ�����), �Ǽ��ɾ�(�Ѽ��ɾ�-(����*����3%)) ��ȸ
SELECT EMP_NAME, SALARY*12, (SALARY*(1+BONUS))*12, (SALARY*(1+BONUS))*12 - (SALARY*12*0.03)
FROM EMPLOYEE;
-- ������ 	96000000	124800000	121920000

-- 2. EMPLOYEE���̺��� �̸�, �����, �ٹ��ϼ�(���� ��¥ - �����) ��ȸ
--      ���� ��¥ : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
-- ������	90/02/06	11336.372962962962962962962962962962963

SELECT SYSDATE
FROM EMPLOYEE;
-- 21/02/19

SELECT SYSDATE
FROM DUAL;
-- 21/02/19




-- �÷� ��Ī
-- �÷��� AS ��Ī / �÷��� "��Ī" / �÷��� AS "��Ī" / �÷��� ��Ī
-- ��Ī�� ���⳪ Ư�����ڰ� ���Ե� ��� ������ "" ��� : �÷��� (AS) "��Ī"

SELECT EMP_NAME AS �̸�, SALARY*12 "����(��)", (SALARY + (SALARY*BONUS))*12 AS "�Ѽҵ�(��)"
FROM EMPLOYEE;

SELECT EMP_NAME AS �̸�, SALARY*12 AS ����, (SALARY*(1+BONUS))*12 "�Ѽ��ɾ�(���ʽ� ����)", (SALARY*(1+BONUS))*12 - (SALARY*12*0.03) AS "�Ǽ��ɾ�"
FROM EMPLOYEE;

SELECT EMP_NAME �̸�, HIRE_DATE ��볯¥, SYSDATE - HIRE_DATE �ٹ��ϼ�
FROM EMPLOYEE;

-- ���ͷ�
-- ���ڳ� ��¥���ͷ��� ''��ȣ ���
SELECT *
FROM EMPLOYEE
WHERE ENT_YN = 'Y';

SELECT *
FROM EMPLOYEE
WHERE EMP_NAME = '������';

-- EMPLOYEE ���̺��� ������ ���� ��ȣ, ��� ��, �޿�, ����(������ ��:��) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, '��'
FROM EMPLOYEE;
-- SELECT���� �̿��ϸ� ���̺� �����ϴ� ������ó�� ����� �� ����

-- DISTINCT : �÷��� ���Ե� �ߺ����� �� ������ ǥ���ϰ��� �� �� ���
-- EMPLOYEE���̺��� ������ ���� �ڵ� ��ȸ
SELECT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ������ ���� �ڵ�(�ߺ� ����) ��ȸ
-- DISTINCT�� SELECT���� �� �� ���� �� �� ����
-- SELECT DISTINCT DEPT_CODE, DISTINCT JOB_CODE
-- FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;


-- WHERE ��
-- ��ȸ�� ���̺��� ������ �´� ���� ���� ���� ���
-- SELECT �÷���
-- FROM ���̺��
-- WHERE ����;
-- �� ������
-- > ũ��, �۴�, >= ũ�ų� ����, <= �۰ų� ����
-- = ����, != / ^= / <> ���� �ʴ�

-- EMPLOYEE���̺��� �μ��ڵ尡 D9�� ������ �̸�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE���̺��� �޿��� 4000000 �̻��� ������ �̸�, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE ���̺��� �μ��ڵ尡 D9�� �ƴ� ����� ���, �̸�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE ^= 'D9';
-- WHERE DEPT_CODE != 'D9';
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE���̺��� ��翩�ΰ� N�� ������ ��ȸ�ϰ�
-- �ٹ� ���θ� ���������� ǥ���Ͽ� ���, �̸�, �����, �ٹ����� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, '������' �ٹ�����
FROM EMPLOYEE
WHERE ENT_YN = 'N';

------- �ǽ����� -------
-- 1. EMPLOYEE���̺��� ������ 3000000 �̻��� ����� �̸�, ����, ����� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. EMPLOYEE���̺��� SAL_LEVEL�� S1�� ����� �̸�, ����, �����, ����ó ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

-- 3. EMPLOYEE ���̺��� �Ǽ��ɾ�(�Ѽ��ɾ� - (����*����3%))�� 5õ���� �̻��� ����� �̸�, ����, �Ǽ��ɾ�, ����� ��ȸ
SELECT EMP_NAME, SALARY, (SALARY*(1+BONUS))*12 - (SALARY*12*0.03), HIRE_DATE
FROM EMPLOYEE
WHERE (SALARY*(1+BONUS))*12 - (SALARY*12*0.03) >= 50000000;

-- �������� (AND, OR)
-- ���� �� ���� �ۼ� �� ���
-- EMPLOYEE ���̺��� �μ� �ڵ尡 D6�̰� �޿��� 3�鸸���� ���� �޴� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY > 3000000;

-- EMPLOYEE ���̺��� �μ��ڵ尡 D6�̰ų� �޿��� 3�鸸���� ���� �޴� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY > 3000000;

-- EMPLOYEE ���̺��� �޿��� 350���� �̻� 600���� ���ϸ� �޴� ����� ���, �̸�, �޿�, �μ��ڵ�, �����ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

------- �ǽ� ���� -------
-- 1. EMPLOYEE ���̺� ������ 4000000 �̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

-- 2. EMPLOYEE ���̺� DEPT_CODE�� D9�̰ų� D5�� ��� �� ������� 02�� 1�� 1�Ϻ��� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5') AND HIRE_DATE < '02/01/01';

-- BETWEEN AND
-- �÷��� BETWEEN A AND B : A = ���Ѱ� / B = ���Ѱ�
-- ���Ѱ� �̻� ���Ѱ� ����
-- �޿��� 350�� �̻� �ް� 600�� ���Ϸ� �޴� ��� �̸�, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SALARY >= 3500000 AND SALARY <= 6000000;
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- �޿��� 350�� �̸� �Ǵ� 600�� �ʰ��ϴ� ������ ���, �̸�, �޿�, �μ��ڵ�, ���� �ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY < 3500000 OR SALARY > 6000000;

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;

------- �ǽ� ���� -------
-- 1. EMPLOYEE ���̺� ������� 90/01/01 ~ 01/01/01�� ����� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-- LIKE
-- ���Ϸ��� ���� ������ Ư�� ������ ������Ű���� ��ȸ�� ��
-- �÷��� LIKE '��������'
-- % / _
-- % : 0���� �̻�
-- _ : 1����
-- '����%' : ���ڷ� �����ϴ� �� (���ڹڽſ�, ���ھ�, �����ΰ���?, ����)
-- '%����%' : ���ڰ� ���Ե� �� (����, ���ڹڽſ�, �̰Թ����ھ�)
-- '%����' : ���ڷ� ������ �� (����, ���۱���)
-- '��%��' : �۷� �����ؼ� �ڷ� ������ �� (����, ���� ������ �Ẹ��)
-- '_' : �� ����
-- '__' : �� ����

-- EMPLOYEE ���̺��� ���� ������ ����� ���, �̸�, ����� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- EMPLOYEE ���̺��� �̸��� '��'�� �� ������ �̸�, �ֹι�ȣ, �μ��ڵ� ��ȸ
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- EMPLOYEE ���̺��� ��ȭ��ȣ 4��°�ڸ��� 9�� �����ϴ� ����� ���, �̸�, ��ȭ��ȣ ��ȸ
SELECT EMP_NO, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- EMPLOYEE ���̺��� �̸��� �� _�� �ձ��ڰ� 3�ڸ��� �̸��� �ּҸ� ���� ����� ���, �̸�, �̸��� ��ȸ
SELECT EMP_NO, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%'; 
-- ���ϵ�ī���� ���ڿ� �˻��ϰ��� �ϴ� Ư�����ڰ� ������ ���
-- � ���� �����̰� � ���� Ư���������� �������� ����
-- ESCAPE OPTION�� ���� �����ͷ� ó���� ���ڸ� ���н��� ��
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___*_%' ESCAPE '*';

-- EMPLOYEE ���̺��� �达 ���� �ƴ� ������ ���, �̸�, ����� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE EMP_NAME NOT LIKE '��%';
WHERE NOT EMP_NAME LIKE '��%';

------- �ǽ� ���� -------
-- 1. EMPLOYEE ���̺��� �̸� ���� '��'���� ������ ����� �̸� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- 2. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

-- 3. EMPLOYEE ���̺��� �����ּ� '_'�� ���� 4���̸鼭 DEPT_CODE�� D9 �Ǵ� D6�̰� ������� 90/01/01 ~ 00/12/01�̰�, �޿��� 270�� �̻��� ����� ��ü�� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE (EMAIL LIKE '____*_%' ESCAPE '*') AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6') AND (HIRE_DATE BETWEEN '90/01/01' AND '00/12/01') AND (SALARY >= 2700000);

-- IS NULL / IS NOT NULL
-- IS NULL : �÷� ���� NULL�� ���
-- IS NOT NULL : �ø� ���� NULL�� �ƴ� ���
-- EMPLOYEE ���̺��� ���ʽ��� ���� �ʴ� ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- EMPLOYEE ���̺��� ���ʽ��� �޴� ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
-- WHERE BONUS IS NOT NULL;
WHERE NOT BONUS IS NULL;

-- EMPLOYEE ���̺��� �����ڵ� ���� �μ���ġ�� ���� ���� ������ �̸�, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE (MANAGER_ID IS NULL) AND (DEPT_CODE IS NULL);

-- EMPLOYEE ���̺��� �μ���ġ�� ���� �ʾ����� ���ʽ��� ���޹޴� ������ �̸�, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE (BONUS IS NOT NULL) AND (DEPT_CODE IS NULL);

-- IN
-- ��Ͽ� ��ġ�ϴ� ���� ������ TRUE�� ��ȯ�ϴ� ������
-- �÷��� IN (���1, ���2, ���3, ...)
-- D6�μ��� D9�μ����� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D9';

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN('D6', 'D9');

-- ���� �ڵ尡 J1, J2, J3, J4�� ������� �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J1' OR JOB_CODE = 'J2' OR JOB_CODE = 'J3' OR JOB_CODE = 'J4';

SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN('J1', 'J2', 'J3', 'J4');

-- ���� ������ ||
-- ���� �÷��� �ϳ��� �÷��� ��ó�� �����ϰų� �÷��� ���ͷ��� ������ �� ����
-- EMPLOYEE ���̺��� ���, �̸�, �޿��� �����Ͽ� ��ȸ
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� '��� ���� ������ �޿����Դϴ�' �������� ��ȸ
SELECT EMP_NAME || '�� ������ ' || SALARY || '���Դϴ�' ����
FROM EMPLOYEE;

-- ������ �켱����
/*
    1. ��� ������
    2. ���� ������
    3. �� ������
    4. IS NULL / IS NOT NULL, LIKE, IN / NOT IN
    5. BETWEEN AND / NOT BETWEEN AND
    6. NOT
    7. AND
    8. OR
*/
-- J7 �Ǵ� J2 ������ �޿� 200���� �̻� �޴� ������ �̸�, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE IN('J7', 'J2') AND SALARY >= 2000000;
-- WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;




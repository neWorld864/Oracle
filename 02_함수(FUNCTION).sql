-- �Լ�(FUNCTION) : �÷��� ���� �о ����� ����� ����
-- ������(SINGLE ROW)�Լ� : �÷��� ��ϵ� n���� ���� �о n���� ����� ����
-- �׷�(GROUP)�Լ� : �÷��� ��ϵ� n���� ���� �о 1���� ����� ����

-- SELECT���� ������ �Լ��� �׷��Լ��� ���� ��� �� �� : ��� ���� ������ �ٸ��� ����

-- �Լ��� ����� �� �ִ� ��ġ : SELECT��, WHERE��, GROUP BY��, HAVING��, ORDER BY��

-- ������ �Լ�
-- 1. ���� ���� �Լ�
-- LENGTH / LENGTHB
-- LENGTHB : ������ ����Ʈ ������ ��ȯ : �ѱ��� �� ���� �� 3����Ʈ, ����� 1����Ʈ
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL; -- DUAL : ���� ���̺�
-- 3	9

SELECT LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;
-- 15	15 / 16	  16 / 14	14

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- INSTR : �ش� ���ڿ��� ��ġ -- ���� �ε��� �ƴ�! �׳� 1 2 3 4 ��
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- 3
SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL; -- 0 : ���ٴ� �ǹ��� 0
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 3 : �տ������� �����ϴ� ��
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- 10 : �ڿ������� �����ϴ� ��
SELECT INSTR('AABAACAABBAA', 'C', -1) FROM DUAL; -- 6
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 9 : �տ������� �� ��° B
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL; -- 9

-- EMPLOYEE ���̺��� �̸����� @��ġ ��ȯ
SELECT INSTR(EMAIL, '@'), EMAIL
FROM EMPLOYEE;
-- 7	sun_di@kh.or.kr

-- LPAD / RPAD : ����ֱ�
SELECT LPAD(EMAIL, 20), RPAD(EMAIL, 20) FROM EMPLOYEE;
--      sun_di@kh.or.kr
-- sun_di@kh.or.kr     

SELECT LPAD(EMAIL, 20, '#'), RPAD(EMAIL, 20, '#') FROM EMPLOYEE;
-- #####sun_di@kh.or.kr
-- sun_di@kh.or.kr#####

-- LTRIM / RTRIM : LTRIM�� �� ���ʿ� �ִ� ���ڰ� RTRIM�̸� �� �����ʿ� �ִ� ���ڰ� ' ' �ȿ� ���Ե� ���ڸ� �ڸ� 
SELECT EMP_NAME, PHONE, LTRIM(PHONE, '010'), EMAIL, RTRIM(EMAIL, '@kh.or.kr')
FROM EMPLOYEE;
-- song_jk@kh.or.kr / loo_or@kh.or.kr
-- song_j / loo_
-- 0179964233 / 0113654485
-- 79964233 / 3654485

SELECT LTRIM('   KH') FROM DUAL; -- KH
SELECT LTRIM('KH', ' ') FROM DUAL; -- KH
SELECT LTRIM('   K   H') FROM DUAL; -- K   H
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL; -- KH
SELECT LTRIM('123123KH123', '123') FROM DUAL; -- KH123
SELECT RTRIM('KH   ') A FROM DUAL; -- KH
SELECT RTRIM('KH324657', '0123456789') FROM DUAL; -- KH


-- TRIM
SELECT TRIM('   KH   ') A FROM DUAL; -- KH
SELECT TRIM('Z' FROM 'ZZZKHZZZZ') FROM DUAL; -- KH(����) : ���� ������ �������� ����
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZZ') FROM DUAL; -- KHZZZZ(����) : ���� ������
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZZ') FROM DUAL; -- ZZZKH(����) : ������ ������
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZZ') FROM DUAL; -- KH(����) : ���� ���� ������ ����

-- SUBSTR
-- �÷��̳� ���ڿ����� ������ ��ġ���� ������ ������ ���ڿ��� �߶󳻾� ��ȯ = �ڹٿ� String.subString()
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- THEMONEY
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL; -- ME
SELECT SUBSTR('SHOWMETHEMONEY', 5, 0) FROM DUAL; -- (NULL)
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL; -- SHOWME
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL; -- THE
SELECT SUBSTR('SHOWMETHEMONEY', -10, 2) FROM DUAL; -- ME
SELECT SUBSTR('��� �� �� �Ӵ�', 2, 5) FROM DUAL; -- �� �� ��

-- EMPLOYEE ���̺��� �̸�, �̸���, @���ĸ� ������ ���̵� ��ȸ
SELECT EMAIL FROM EMPLOYEE;
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1)
FROM EMPLOYEE;
-- ������ sun_di@kh.or.kr sun_di ...

-- �ֹε�Ϲ�ȣ�� �̿��Ͽ� ��/�� �Ǵ�
-- EMPLOYEE���̺��� �̸��� �ֹι�ȣ���� ������ ��Ÿ���� �κ� ��ȸ
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1)
FROM EMPLOYEE;
-- ������	 1
-- ������ 2 ...

-- EMPLOYEE���̺��� ���ڸ� ��ȸ
SELECT EMP_NAME, '��' ����
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;
-- ������	�� ...

-- EMPLOYEE���̺��� ���ڸ� ��ȸ
SELECT EMP_NAME, '��' ����
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) =2;
-- ������	�� ...

-- EMPLOYEE���̺��� �������� �ֹι�ȣ�� �̿��Ͽ� ��� ��, ����, ����, ���� ��ȸ
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 2) ����, SUBSTR(EMP_NO, 3, 2) ����, SUBSTR(EMP_NO, 5, 2) ����
FROM EMPLOYEE;
-- ������	 62	 12	 35 ...

-- LOWER / UPPER / INITCAP
SELECT LOWER('Welcome To My World') FROM DUAL; -- welcome to my world
SELECT UPPER('Welcome To My World') FROM DUAL; -- WELCOME TO MY WORLD
SELECT INITCAP('welcome to my world') FROM DUAL; -- Welcome To My World

-- CONCAT
SELECT CONCAT('�����ٶ�', 'ABCD') FROM DUAL; -- �����ٶ�ABCD
SELECT '�����ٶ�' || 'ABCD' FROM DUAL; -- �����ٶ�ABCD

-- REPLACE
SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') FROM DUAL; -- ����� ������ �Ｚ��

-- EMPLOYEE ���̺��� �̸����� �������� gmail.com �����ϱ�
SELECT REPLACE(EMAIL, 'kh.or.kr', 'gmail.com') FROM EMPLOYEE;
-- sun_di@gmail.com ...

-- EMPLOYEE���̺��� ��� ��, �ֹι�ȣ ��ȸ
-- ��, �ֹι�ȣ�� ������ϸ� ���̰��ϰ� '-' ���� ���� '*'�� �ٲٱ�
SELECT EMP_NAME "��� ��", REPLACE(EMP_NO, SUBSTR(EMP_NO, 8, 7), '*******') �������
FROM EMPLOYEE;

SELECT EMP_NAME "��� ��", SUBSTR(EMP_NO, 1, 7) || '*******' �������
FROM EMPLOYEE;

SELECT EMP_NAME "��� ��", RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*') �������
FROM EMPLOYEE;

SELECT EMP_NAME "��� ��", RPAD(SUBSTR(EMP_NO, 1, 7), LENGTH(EMP_NO), '*') �������
FROM EMPLOYEE;
-- ������ 621235-******* ...


-- 2. ���� ���� �Լ�
-- ABS : ���밪 ����
SELECT ABS(10.9) FROM DUAL; -- 10.9
SELECT ABS(-10.9) FROM DUAL; -- 10.9
SELECT ABS(10) FROM DUAL; -- 10
SELECT ABS(-10) FROM DUAL; -- 10

-- MOD : ������ ���� -> ���������� ���� ��ȣ�� ����
SELECT MOD(10, 3) FROM DUAL; -- 1
SELECT MOD(-10, 3) FROM DUAL; -- -1
SELECT MOD(10, -3) FROM DUAL; -- 1
SELECT MOD(-10, -3) FROM DUAL; -- -1
SELECT MOD(10.9, 3) FROM DUAL; -- 1.9
SELECT MOD(-10.9, 3) FROM DUAL; -- -1.9

-- ROUND
SELECT ROUND(123.456) FROM DUAL; -- 123
SELECT ROUND(123.678) FROM DUAL; -- 124
SELECT ROUND(123.678, 0) FROM DUAL; -- 124
SELECT ROUND(123.678, 1) FROM DUAL; -- 123.7
SELECT ROUND(123.678, 2) FROM DUAL; -- 123.68
SELECT ROUND(123.678, -2) FROM DUAL; -- 100
SELECT ROUND(-10.61) FROM DUAL; -- -11

-- FLOOR : ���� -> �ڸ��� ���� �Ұ�
SELECT FLOOR(123.456) FROM DUAL; -- 123
SELECT FLOOR(123.678) FROM DUAL; -- 123

-- TRUNC -> �ڸ��� ���� ����
SELECT TRUNC(123.456) FROM DUAL; -- 123
SELECT TRUNC(123.678) FROM DUAL; -- 123
SELECT TRUNC(123.465, 1) FROM DUAL; -- 123.4
SELECT TRUNC(123.465, 2) FROM DUAL; -- 123.46
SELECT TRUNC(123.465, -1) FROM DUAL; -- 120

-- CEIL : �ø�
SELECT CEIL(123.456) FROM DUAL; -- 124
SELECT CEIL(123.678) FROM DUAL; -- 124


-- 3. ��¥ ���� �Լ�
-- SYSDATE : ���� ��¥�� ��ȯ�ϴ� �Լ�
SELECT SYSDATE FROM DUAL; -- 21/02/08

-- MONTHS_BETWEEN : ���� ���� ���̸� ���ڷ� �����ϴ� �Լ�
-- EMPLOYEE���̺��� ����� �̸�, �Ի���, �ٹ� ������ ��ȸ
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEE;
-- ������ 	90/02/06	372.419933542413381123058542413381123059 ...

SELECT EMP_NAME, HIRE_DATE, ABS(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
FROM EMPLOYEE;
-- ������	  90/02/06	372.419939142771804062126642771804062127 ...

SELECT EMP_NAME, HIRE_DATE, CEIL(ABS(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))) || '������' ������
FROM EMPLOYEE;
-- ������ 	90/02/06	373������ ...

-- ADD_MONTHS : ��¥�� ���ڸ�ŭ �������� ���� ��¥ ����
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL; -- 21/07/08
SELECT ADD_MONTHS(SYSDATE, 12) FROM DUAL; -- 22/02/08

-- NEXT_DAY : ���� ��¥���� ���Ϸ��� ���Ͽ� ���� ����� ��¥�� �����ϴ� �Լ�
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�����') FROM DUAL; -- 21/02/08	21/02/11
SELECT SYSDATE, NEXT_DAY(SYSDATE, 5) FROM DUAL; -- 21/02/08	21/02/11 : 1=��, ... , 7=��
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL; -- 21/02/08	21/02/11
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�����ֽ� ���ְڴ�') FROM DUAL; -- 21/02/08	21/02/10
SELECT SYSDATE, NEXT_DAY(SYSDATE, '������ ����� �̸��� ���� ����') FROM DUAL; -- ����, �� �� ���ڰ� ���� ���ڿ��� ��

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL; -- ���� ORA-01846: not a valid day of the week
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THU') FROM DUAL; -- ���� ORA-01846: not a valid day of the week
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUROSEMARY') FROM DUAL; -- ���� ORA-01846: not a valid day of the week
-- �� ALTER SESSION SET NLS_LANGUAGE = AMERICAN; �� ���ָ� �� ����

-- LAST_DAY : �ش� �޿� ������ ��¥ ����
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL; -- 21/02/08	21/02/28

------- �ǽ� ���� -------
-- 1. EMPLOYEE���̺��� ��� ��, �Ի���-����, ����-�Ի��� ��ȸ
-- ��, ��Ī�� �ٹ��ϼ�1, �ٹ��ϼ�2�� �ϰ� ��� ����ó��(����), ����� �ǵ��� ó��
SELECT EMP_NAME, FLOOR(ABS(HIRE_DATE - SYSDATE)) �ٹ��ϼ�1, FLOOR(ABS(SYSDATE - HIRE_DATE)) �ٹ��ϼ�2
FROM EMPLOYEE;
-- ������ 	11336	11336 ...

-- 2. EMPLOYEE���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) <> 0;
-- 201	������	631156-1548654	song_jk@kh.or.kr	01045686656	D9	J2	S1	6000000		200	01/09/01		N
-- 203	������	631010-2653546	song_eh@kh.or.kr	01077607879	D6	J4	S5	2800000		204	96/05/03		N ...

-- 3. EMPLOYEE���̺��� �ٹ������ 20�� �̻��� ���� ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE ABS(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) >= 240;

-- ��� 2
SELECT *
FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE; -- ���ڷ� ���޹��� ��¥�� ���ڷ� ���� ���ڸ�ŭ ���� ���� ���Ͽ� Ư�� ��¥ ��ȯ

-- 4. EMPLOYEE���̺��� ��� ��, �Ի���, �Ի��� ���� �ٹ� �ϼ� ��ȸ
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;
-- ������ 	90/02/06	22

-- EXTRACT : ��, ��, �� ������ �����Ͽ� ����
-- EXTRACT(YEAR FROM ��¥)
-- EXTRACT(MONTH FROM ��¥)
-- EXTRACT(DAY FROM ��¥)
-- EMPLOYEE���̺��� ����� �̸�, �Ի� ����, �Ի� ��, �Ի� �� ��ȸ
SELECT EMP_NAME �����,
        EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵,
        EXTRACT(MONTH FROM HIRE_DATE) �Ի��,
        EXTRACT(DAY FROM HIRE_DATE) �Ի���
FROM EMPLOYEE
--ORDER BY EMP_NAME;
--ORDER BY EMP_NAME ASC; -- ��������
--ORDER BY EMP_NAME DESC; -- ��������
--ORDER BY �����;
--ORDER BY "�Ի�⵵" DESC, �����; -- �Ի�⵵ ���� ���� 
--ORDER BY "�Ի�⵵", ����� DESC;
ORDER BY 1; -- ���̺� 1���� �������� �����ϰڴ�
-- ���ؼ�	 2004	4	30 ...

-- EMPLOYEE���̺��� ����� �̸�, �Ի���, �ٹ���� ��ȸ
-- �� �ٹ������ (���� �⵵ - �Ի�⵵)�� ��ȸ
SELECT EMP_NAME, HIRE_DATE, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) �ٹ����
FROM EMPLOYEE;
-- ������	 90/02/06	31 ...


-- 4. �� ��ȯ �Լ�
-- TO_CHAR : ��¥��/������ �����͸� ������ �����ͷ� ����
SELECT TO_CHAR(1234) FROM DUAL; -- 1234
SELECT TO_CHAR(1234, '99999') FROM DUAL; --   1234 : 5ĭ ������ ����, ��ĭ ����
SELECT TO_CHAR(1234, '00000') FROM DUAL; --  01234 : 5ĭ ������ ����, ��ĭ 0
SELECT TO_CHAR(1234, 'FML99999') FROM DUAL; -- ��1234
-- FM: �������� / L:�� ���� ȭ�����
SELECT TO_CHAR(1234, '$99999') FROM DUAL; --   $1234
SELECT TO_CHAR(1234, 'FMS99999') FROM DUAL; -- +1234
SELECT TO_CHAR(1234, '99,999') FROM DUAL; --   1,234
SELECT TO_CHAR(1234, 'FM99,999') FROM DUAL; -- 1,234
SELECT TO_CHAR(1234, '00,000') FROM DUAL; --  01,234
SELECT TO_CHAR(1234, '999') FROM DUAL; -- ####

-- EMPLOYEE���̺��� ��� ��, �޿� ǥ��
-- �޿��� '\9,000,000'�������� ǥ��
SELECT EMP_NAME, TO_CHAR(SALARY, 'FML9,999,999')
FROM EMPLOYEE;
-- ������	 ��8,000,000 ...

SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL; -- ���� 13:39:12
SELECT TO_CHAR(SYSDATE, 'AM HH24:MI:SS') FROM DUAL; -- ���� 13:39:17
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- ���� 01:39:23
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL; -- 2��  ��, 2021 / 2��  ��, 2021
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL; -- 2021-02-08 ������
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY') FROM DUAL; -- 2021-2-8 ������
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') FROM DUAL; -- TWENTY TWENTY-ONE, 1

SELECT TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'YEAR')  
FROM DUAL;
-- 2021	21	TWENTY TWENTY-ONE

SELECT TO_CHAR(SYSDATE, 'MM'), 
        TO_CHAR(SYSDATE, 'MONTH'), 
        TO_CHAR(SYSDATE, 'MON'), 
        TO_CHAR(SYSDATE, 'RM')
FROM DUAL;
-- 02	2�� 	2�� 	II  

SELECT TO_CHAR(SYSDATE, 'DDD'),
        TO_CHAR(SYSDATE, 'DD'),
        TO_CHAR(SYSDATE, 'D')
FROM DUAL;
-- 050	19	6

-- EMPLOYEE���̺��� �̸�, �Ի��� ��ȸ
-- �Ի����� '2021�� 02�� 08�� (��)' �������� ���
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��" "("DY")"')
FROM EMPLOYEE;
-- ������	1990�� 02�� 06�� (ȭ)

-- TO_NUMBER : ������ �����͸� ������ ������
SELECT TO_NUMBER('123456') FROM DUAL;
-- 123456

SELECT '123' + '456' FROM DUAL; -- 579
SELECT '1,000,000' + '550,000' FROM DUAL;
SELECT TO_NUMBER('1,000,000', '9,999,999') + TO_NUMBER('550,000', '999,999') FROM DUAL; -- 1550000
--             ��ȯ�Ϸ��� ������   ��� ����

-- TO_DATE
SELECT TO_DATE('20210101', 'YYYYMMDD') FROM DUAL; -- 21/01/01
SELECT TO_DATE(20210101, 'YYYYMMDD') FROM DUAL; -- 21/01/01
SELECT TO_CHAR(TO_DATE('20210208', 'YYYYMMDD'), 'YYYY, MON') FROM DUAL; -- 2021, 2�� 

-- RR�� YY�� ����
SELECT TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYYYMMDD') FROM DUAL; -- 20980630
SELECT TO_CHAR(TO_DATE('210630', 'YYMMDD'), 'YYYYMMDD') FROM DUAL; -- 20210630
SELECT TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYYMMDD') FROM DUAL; -- 19980630
SELECT TO_CHAR(TO_DATE('210630', 'RRMMDD'), 'YYYYMMDD') FROM DUAL; -- 20210630
-- YY : 20 / RR : ��¿ �� 19 ��¿ �� 20

-- 5. NULL ó�� �Լ�
-- NVL : �÷� ���� NULL�� �� �ٲ� ������ ��ü
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;
-- ������	 (null)	  0 ...

SELECT EMP_NAME, NVL(DEPT_CODE, '�����ϴ�')
FROM EMPLOYEE;
-- �ϵ���	 �����ϴ�

-- NVL2 : �ش� �÷��� ���� ������ �ٲ� ��1�� ����, �ش� �÷��� ���� ������ �ٲ� ��2�� ����
-- EMPLOYEE���̺��� ���ʽ��� NULL�� ������ 0.5��, NULL�� �ƴ� ��� 0.7 ����
SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.5)
FROM EMPLOYEE;
-- ������	  0.3	0.7
-- ������	 	    0.5

-- NULLIF : �� ���� ���� �����ϸ� NULL, �׷��� ������ �񱳴��1 ����
SELECT NULLIF(123, 123) FROM DUAL; -- (NULL)
SELECT NULLIF(123, 124) FROM DUAL; -- 123


-- 6. ���� �Լ�
-- DECODE : ���ϰ����ϴ� �� �Ǵ� �÷��� ���ǽİ� ������ ��� �� ��ȯ(SWITCH)
SELECT EMP_ID, EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��')
FROM EMPLOYEE;
-- 200	������	621235-1985634	��

SELECT EMP_ID, EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', '��')
FROM EMPLOYEE;
-- 200	������	621235-1985634	��

-- ������ �޿��� �λ��ϰ��� �Ѵ�
-- �����ڵ尡 J7�� ������ �޿��� 10%�� �λ��ϰ�
-- �����ڵ尡 J6�� ������ �޿��� 15%�� �λ��ϰ�
-- �����ڵ尡 J5�� ������ �޿��� 20%�� �λ��ϸ�
-- �� �� ������ ������ �޿��� 5%�� �λ��Ѵ�.
-- ���� ���̺��� ������, �����ڵ�, �޿�, �λ�޿�(�� ����)�� ��ȸ�ϼ���
SELECT EMP_NAME, JOB_CODE, SALARY,
        DECODE(JOB_CODE, 'J7', SALARY*1.1, 
                         'J6', SALARY*1.15, 
                         'J5', SALARY*1.2, 
                         SALARY*1.05) �λ�޿�
FROM EMPLOYEE;
-- ������	    J1	8000000	8400000
-- ������ 	J2	6000000	6300000


-- CASE WHEN ���ǽ� THEN �����
--      WHEN ���ǽ� THEN �����
--      ELSE �����
-- END
-- ���ϰ��� �ϴ� �� �Ǵ� �÷��� ���ǽİ� ������ ��� �� ��ȯ, ������ ���� �� ����

SELECT EMP_ID, EMP_NAME, EMP_NO, 
        CASE WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '����'
             WHEN SUBSTR(EMP_NO, 8, 1) = 2 THEN '����'
        END ����
FROM EMPLOYEE;
-- 200	������	621235-1985634	����

SELECT EMP_ID, EMP_NAME, EMP_NO, 
        CASE WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '����'
             ELSE '����'
        END ����
FROM EMPLOYEE;
-- 200	������	621235-1985634	����

SELECT EMP_NAME, JOB_CODE, SALARY,
        CASE WHEN JOB_CODE = 'J7' THEN SALARY*1.1
             WHEN JOB_CODE = 'J6' THEN SALARY*1.15
             WHEN JOB_CODE = 'J5' THEN SALARY*1.2
             ELSE SALARY*1.05
             END �λ�޿�
FROM EMPLOYEE;
-- ������  J1  8000000	8400000

SELECT EMP_NAME, JOB_CODE, SALARY,
        CASE JOB_CODE WHEN 'J7' THEN SALARY*1.1
                      WHEN 'J6' THEN SALARY*1.15
                      WHEN 'J5' THEN SALARY*1.2
                      ELSE SALARY*1.05
             END �λ�޿�
FROM EMPLOYEE;
-- ������	 J1	8000000	8400000

SELECT EMP_ID, EMP_NAME, SALARY,
         CASE WHEN SALARY > 5000000 THEN '1���'
              WHEN SALARY > 5000000 THEN '1���'
              WHEN SALARY > 5000000 THEN '1���'
              ELSE '4���'
         END ���
FROM EMPLOYEE;       
-- 200	������	8000000	1���
    
    
-- �׷� �Լ�
-- ���� ���� ���� ������ �� ���� ����� �����ϴ� �Լ�
-- SUM
-- EMPLOYEE���̺��� �� ����� �޿� ����
SELECT SUM(SALARY)
FROM EMPLOYEE; -- 74396240

-- EMPLOYEE���̺��� ���� ����� �޿� ���� ��ȸ
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1; -- 54060000

-- EMPLOYEE���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ���� �հ� ��ȸ
SELECT SUM((SALARY + (SALARY*BONUS))*12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'; -- 77340000


-- AVG
-- EMPLOYEE���̺��� �� ����� �޿� ���
SELECT AVG(SALARY)
FROM EMPLOYEE; -- 3099843.33333333333333333333333333333333

-- EMPLOYEE���̺��� �� ����� ���ʽ� ����� �Ҽ� ��°�ڸ����� �ݿø��� �� ��ȸ
-- BONUS�� NULL�� ����� 0���� ó��
SELECT ROUND(AVG(NVL(BONUS, 0)), 2)
FROM EMPLOYEE; -- 0.09

-- MIN
-- EMPLOYEE ���̺��� ���� ���� �޿� ��ȸ
SELECT MIN(SALARY)
FROM EMPLOYEE; -- 1380000

-- EMPLOYEE���̺��� ���ĺ� ������ ���� ���� �̸���, ���� ���� �Ի��� ��ȸ
SELECT MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;
-- bang_ms@kh.or.kr  90/02/06

-- MAX
-- EMPLOYEE���̺��� ���� ���� �޿� ��ȸ
SELECT MAX(SALARY)
FROM EMPLOYEE; -- 8000000

-- EMPLOYEE���̺��� ���ĺ� ������ ���� ���� �̸���, ���� �ֱ� �Ի��� ��ȸ
SELECT MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;
-- youn_eh@kh.or.kr	 21/02/17

-- COUNT : NULL ������
SELECT COUNT(*) /*�� ����*/, COUNT(DEPT_CODE)/*���� �ƴѰ� ����*/, COUNT(DISTINCT DEPT_CODE) /*-- �ߺ��� ������ ����*/  -- 23	21	6
FROM EMPLOYEE;
-- 24	22	6


---------- �Լ� �������� ----------
--1. ������� �ֹι�ȣ�� ��ȸ��
--  ��, �ֹι�ȣ 9��° �ڸ����� �������� '*'���ڷ� ä��
--  �� : ȫ�浿 771120-1******
SELECT EMP_NAME "���� ��", SUBSTR(EMP_NO, 1, 8) || '******' �������
FROM EMPLOYEE;
-- ������	621235-1******

--2. ������, �����ڵ�, ���ʽ��� ���Ե� ����(��) ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
SELECT EMP_NAME, JOB_CODE, TO_CHAR((SALARY*(1+NVL(BONUS, 0)))*12, 'FML999,999,999') "���ʽ� ���� ����"
FROM EMPLOYEE;
-- ������	J1	��124,800,000

--3. �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� ������ ���, �����, �μ��ڵ�, �Ի���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D5' OR DEPT_CODE = 'D9') AND  EXTRACT(YEAR FROM HIRE_DATE) = 2004;
-- 208	���ؼ�	D5	04/04/30

--4. ������, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ(��, �ָ��� �Ի��� ���� �ٹ��ϼ��� ������)
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE) - HIRE_DATE + 1
FROM EMPLOYEE;
-- ������  90/02/06	23

--5. �μ��ڵ尡 D5�� D6�� �ƴ� ������� ������, �μ��ڵ�, �������, ����(��) ��ȸ
--  ��, ��������� �ֹι�ȣ���� �����ؼ� ������ ������ �����Ϸ� ��µǰ� �ϰ�
--  ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ���� ���
SELECT EMP_NAME, DEPT_CODE, 
        SUBSTR(EMP_NO, 1, 2) || '�� ' || SUBSTR(EMP_NO, 3, 2) || '�� ' || SUBSTR(EMP_NO, 5, 2) || '��' ����,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RRRR')) ����
FROM EMPLOYEE;
-- ������	 D9	 62�� 12�� 35��	59

--6. �������� �Ի��Ϸ� ���� �⵵�� ������, �� �⵵�� �Ի��ο����� ���Ͻÿ�.
--  �Ʒ��� �⵵�� �Ի��� �ο����� ��ȸ�Ͻÿ�.
--  => to_char, decode, count ���
--   -------------------------------------------------------------
--   ��ü������   2001��   2002��   2003��   2004��
--   -------------------------------------------------------------
SELECT COUNT(*) ��ü������, 
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2001', 1)) "2001��",
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2002', 1)) "2002��",
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2003', 1)) "2003��",
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2004', 1)) "2004��"
FROM EMPLOYEE;
-- 24	3	0	0	1

--7.  �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ��
--  => case ���
SELECT EMP_NAME, DEPT_CODE,
        CASE WHEN DEPT_CODE = 'D5' THEN '�ѹ���'
             WHEN DEPT_CODE = 'D6' THEN '��ȹ��'
             WHEN DEPT_CODE = 'D9' THEN '������'
             END �μ�
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D6' OR DEPT_CODE = 'D9'
ORDER BY 3;
-- ������	 D6	 ��ȹ��
-- �����	 D6	 ��ȹ��
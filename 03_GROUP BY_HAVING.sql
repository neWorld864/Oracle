/* ����
    5 : SELECT      �÷��� AS ��Ī, ����, �Լ���
    1 : FROM        ������ ���̺�
    2 : WHERE       �÷��� �Լ��� �񱳿����� �񱳰�
    3 : GROUP BY    �׷����� ���� �÷���
    4 : HAVING      �׷��Լ��� �񱳿����� �񱳰�
    6 : ORDER BY    �÷��� ��Ī ���� ���Ĺ��
*/

-- GROUP BY�� : ���� ���� ���� ��� �ϳ��� �׷����� ó���� �������� ���
--SELECT DEPT_CODE, SUM(SALARY)
--FROM EMPLOYEE;
-- ORA-00937: not a single-group group function
-- �׷��Լ��� �� �� ���� ��� �� ����, DEPT_CODE ���� �� ��� �� ����

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;


-- EMPLOYEE���̺��� �μ� �ڵ庰 �׷��� �����Ͽ� �μ��ڵ�, �׷캰 �޿��� �հ�,
-- �׷� �� �޿��� ���(����ó��), �ο����� ��ȸ�ϰ� �μ� �ڵ� ������ ����
SELECT DEPT_CODE �μ��ڵ�, SUM(SALARY) �հ�, ROUND(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE���̺��� �μ��ڵ�� ���ʽ��� �޴� ��� ���� ��ȸ�ϰ� �μ��ڵ� ������ ����
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE ���̺��� �����ڵ�, ���ʽ��� �޴� ��� ���� ��ȸ�Ͽ� �����ڵ� ������ �������� ����
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- EMPLOYEE���̺��� ������ ���� �� �޿� ���(����ó��), �޿� �հ�, �ο� �� ��ȸ�ϰ� �ο����� �������� ����
SELECT DECODE(SUBSTR(EMP_NO,8, 1), 1, '��', '��') ����, 
        ROUND(AVG(SALARY)) �޿����, SUM(SALARY) �޿��հ�, COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8, 1), 1, '��', '��')
ORDER BY �ο��� DESC;

-- EMPLOYEE���̺��� �μ� �ڵ� ���� ���� ������ ����� �޿� �հ� ��ȸ
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;

-- HAVING : �׷��Լ��� ���ؿ� �׷쿡 ���� ������ ������ �� ���
-- �μ��ڵ�� �޿� ����� 300�� �̻��� �׷� ��ȸ
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

-- �μ� �� �׷��� �޿� �հ� �� 9�鸸���� �ʰ��ϴ� �μ��ڵ�� �޿� �հ� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000;

-- �����Լ�
-- �׷캰 ������ ��� ���� ���踦 ����ϴ� �Լ�
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY JOB_CODE;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY JOB_CODE;

-- ROLLUP�Լ� : �׷캰�� �߰� ���� ó���� �ϴ� �Լ�
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

-- CUBE
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

-- UNION == OR (������)
-- INTERSECT == AND (������)
-- UNION ALL == OR + AND (������ + ������) --> �ߺ��� �κ��� �� �� ����
-- MINUS (������)

-- UNION : ���� ���� ���� ����� �ϳ��� ��ġ�� ������
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 200
UNION
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 201;

-- UNION�� ����Ͽ� DEPT_CODE�� D5�̰ų� �޿��� 300���� �ʰ��ϴ� ������ ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- 12�� ��

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- 14�� �� : D5�̸鼭 �޿��� 300���� �ʰ��ϴ� ������� �ߺ����� ����

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT -- �ߺ��� ���� �κ��� �����ϴ� ������
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- D5�̸鼭 �޿��� 300���� �� �Ǵ� �����

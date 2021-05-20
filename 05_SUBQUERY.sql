-- SUBQUERY
-- �ϳ��� SQL�� �ȿ� ���Ե� �� �ٸ� SQL��
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY) 
                 FROM EMPLOYEE);


-- �μ��ڵ尡 ���ö����� ���� �Ҽ��� ���� ��� ��ȸ
-- 1) ��� ���� ���ö�� ����� �μ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';

-- 2) �μ��ڵ尡 D9�� ���� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 3) 1+2
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '���ö');
                   
-- �� ������ ��� �޿����� ���� �޿��� �ް� �ִ� ������ ���, �̸�, �����ڵ�, �޿� ��ȸ
-- 1) �� ������ ��� �޿� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 2) ��� �޿����� ���� �޿��� �ް� �ִ� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3047662.60869565217391304347826086956522;

-- 3) 1+2
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEE);
                

-- ���������� ����
-- ������ �������� : ���������� ��ȸ ��� ���� ������ 1���� ��
-- ������ �������� : ���������� ��ȸ ��� ���� ���� ���� ���� ��
-- ���߿� �������� : ���������� SELECT���� ������ �׸� ���� ���� ���� ��
-- ������ ���߿� �������� : ��ȸ ��� �� ���� �� ���� ���� ���� ��

-- ������ ��������
-- �Ϲ������� ������ �������� �տ��� �Ϲ� ������ ���
-- >, <, >=, <=, =, !=/<>/^=
-- ���ö ����� �޿����� ���� �޴� ������ ���, �̸�, �μ��ڵ�, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');
                
-- ���� ���� �޿��� �޴� ������ ���, �̸�, �����ڵ�, �μ��ڵ�, �޿�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > (SELECT MIN(SALARY)
                FROM EMPLOYEE);

-- �� ������ �޿� ��պ��� ���� �޿��� �޴� ������ �̸�, �����ڵ�, �μ��ڵ�, �޿� ��ȸ (���� ������ ����)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE)
ORDER BY JOB_CODE;

-- �μ� �� �޿��� �հ� �� ���� ū �μ��� �μ� ��, �޿� �հ� ��ȸ
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE 
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;

SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE 
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- 18760000

SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
/*
2890000
4300000
8000000
3760000
3900000
2490000
2550000
*/


-- ������ ��������
-- ������ �������� �տ��� �Ϲ� �� ������ ��� ����
-- IN / NOT IN 
--              ���� ���� ��� �� �߿��� �� ���� ��ġ�ϴ� ���� �ִٸ�/���ٸ�
-- > ANY, < ANY
--              ���� ���� ��� �� �߿��� �� ���� ū/���� ���
--              ���� ���� ������ ũ�� / ���� ū ������ �۳�
-- > ALL, < ALL
--              ��� ������ ū/���� ���
--              ���� ���� ������ �۳� / ���� ū ������ ũ��
-- EXISTS / NOT EXISTS
-- ���� �����ϴ���/�������� �ʴ���
-- IN vs EXISTS
--       IN : ���� ã�Ƽ� ��ȯ
--       EXISTS : �ִ�/���� = TRUE/FALSE

-- �μ� �� �ְ� �޿��� �޴� ������ �̸�, ���� �ڵ�, �μ� �ڵ�, �޿� ��ȸ
-- 1) �μ� �� �ְ� �޿�
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                 FROM EMPLOYEE
                 GROUP BY DEPT_CODE);

-- �����ڿ� �Ϲ� ������ �ش��ϴ� ��� ���� ����
-- ���, �̸�, �μ� ��, ����, ����(������/����)
-- 1) �����ڿ� �ش��ϴ� ��� ��ȣ ��ȸ
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

-- 2) ������ ���, �̸�, �μ���, ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE);

-- 3) �����ڿ� �ش��ϴ� ������ ���� ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '������'����
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL);

-- 4) �����ڿ� �ش����� �ʴ� ������ ���� ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME,  '����'����
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL);

-- ��ġ��               
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '������'����
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME,  '����'����
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL);
                 
-- ��� 2
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, 
       CASE WHEN EMP_ID IN (SELECT DISTINCT(MANAGER_ID)
                            FROM EMPLOYEE
                            WHERE MANAGER_ID IS NOT NULL) THEN '������'
            ELSE '����'
       END ����
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE);
     
     
-- �븮 ������ ������ �߿��� ���� ������ �ּ� �޿����� ���� �޴� ������ ���, �̸�, ����, �޿� ��ȸ
-- 1) �븮 ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮';

-- 2) ���� ���� ������ �޿�
SELECT SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';

-- 3) ��ġ��
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
    AND SALARY > ANY(SELECT SALARY
                     FROM EMPLOYEE
                          JOIN JOB USING(JOB_CODE)
                     WHERE JOB_NAME = '����');

-- ���2         
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
    AND SALARY > (SELECT MIN(SALARY)
                  FROM EMPLOYEE
                       JOIN JOB USING(JOB_CODE)
                  WHERE JOB_NAME = '����');
              

-- ���� ������ �޿� �� ���� ū ������ ���� �޴� ���� ������ ���, �̸�, ����, �޿� ��ȸ
-- 1) ���� ���� ������ ���, �̸�, ����, �޿�
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';

-- 2) ���� ������ �޿�
SELECT SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';
                     
-- 3) ��ġ��
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'
    AND SALARY > ALL(SELECT SALARY
                     FROM EMPLOYEE
                          JOIN JOB USING(JOB_CODE)
                     WHERE JOB_NAME = '����');
                     
-- ���2
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'
    AND SALARY > (SELECT MAX(SALARY)
                     FROM EMPLOYEE
                          JOIN JOB USING(JOB_CODE)
                     WHERE JOB_NAME = '����');
                     
-- ���߿� �������� : �ַ� 'IN"�� ��������� �˻� ����� �и��� �� ���� ���� ����ȴٸ� '='�� ����Ѵ�.
-- ���� ���� �÷��� �˻��ϴ� ���� ����
-- ����� �������� ���� �μ�, ���� ���޿� �ش��ϴ� ����� �̸�, ���� �ڵ�, �μ� �ڵ�, �Ի��� ��ȸ
-- 1) ����� �������� �μ�, ����
SELECT JOB_CODE, DEPT_CODE
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2
      AND ENT_YN = 'Y';

-- 2) ����� �������� ���� �μ�, ���� ����
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
      -- ���� �μ�
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE SUBSTR(EMP_NO, 8, 1) = 2
                         AND ENT_YN = 'Y')
      -- ���� ����
      AND JOB_CODE = (SELECT JOB_CODE
                      FROM EMPLOYEE
                      WHERE SUBSTR(EMP_NO, 8, 1) = 2
                            AND ENT_YN = 'Y')
      -- �ߺ� �̸� ����
      AND EMP_NAME != (SELECT EMP_NAME
                       FROM EMPLOYEE
                       WHERE SUBSTR(EMP_NO, 8, 1) = 2
                             AND ENT_YN = 'Y');
                             



-- 3) ��ġ��
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE SUBSTR(EMP_NO, 8, 1) = 2
                                      AND ENT_YN = 'Y')
       AND EMP_NAME != (SELECT EMP_NAME
                       FROM EMPLOYEE
                       WHERE SUBSTR(EMP_NO, 8, 1) = 2
                             AND ENT_YN = 'Y');              
                             
-- ������ ���߿� ��������
-- �ڱ� ������ ��� �޿��� �ް� �ִ� ������ ���, �̸�, ���� �ڵ�, �޿� ��ȸ
-- ��, �޿��� �޿� ����� �ʸ��� ������ ���
-- 1) ���� �� ��� �޿�
SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 2)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
                             FROM EMPLOYEE
                             GROUP BY JOB_CODE);
                             
-- �ζ��� ��(INLINE-VIEW)
SELECT EMP_NAME, ROWNUM FROM EMPLOYEE; -- ��ȣ�� �Ű��� �� �ִ� �÷�

-- �� ���� �� �޿��� ���� ���� 5���� ����, �̸�, �޿� ��ȸ
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC; -- ������, ������, ������, ���ȥ, ���ö
-- ���� ����

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
-- ���� ����, ���� FROM������ ����, FROM������ �Ϲ� EMPLOYEE�� ���⼭ 5���� ������ �� ���¿��� ORDER BY�� ���� ������

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
      FROM EMPLOYEE
      ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

-- �޿� ��� 3�� �ȿ� ��� �μ��� �μ� �ڵ�� �μ� ��, ��� �޿� ��ȸ
SELECT DEPT_CODE, DEPT_TITLE, AVG(SALARY)
FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE ROWNUM <= 3
GROUP BY DEPT_CODE, DEPT_TITLE;

SELECT DEPT_CODE, DEPT_TITLE, ���
FROM (SELECT DEPT_CODE, DEPT_TITLE, AVG(SALARY) ���
      FROM EMPLOYEE
           JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
      GROUP BY DEPT_CODE, DEPT_TITLE
      ORDER BY AVG(SALARY) DESC)
WHERE ROWNUM <= 3;

SELECT DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
   JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
GROUP BY DEPT_CODE, DEPT_TITLE
ORDER BY AVG(SALARY) DESC;

-- WITH / RANK() OVER / DENSE_RANK() OVER
SELECT EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY
      FROM EMPLOYEE
      ORDER BY SALARY DESC);

-- WITH
WITH TOPN_SAL AS(SELECT EMP_NAME, SALARY
                 FROM EMPLOYEE
                 ORDER BY SALARY DESC)
SELECT EMP_NAME, SALARY
FROM TOPN_SAL;

-- RANK() OVER
SELECT ����, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) ����
      FROM EMPLOYEE);
-- 19	������	2000000 / 19	������	2000000 / 21	�ڳ���	1800000

-- DENDE_RANK() OVER
SELECT ����, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) ����
      FROM EMPLOYEE);
-- 19	������	2000000 / 19	������	2000000 / 20	�ڳ���	1800000

-- WITH��
WITH DENSE AS (SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) ����
               FROM EMPLOYEE)
SELECT ����, EMP_NAME, SALARY
FROM DENSE;


------- JOIN & SUBQUERY �ǽ� ���� -------
-- 1. 70��� ��(1970~1979) �� �����̸鼭 ������ ����� �̸��� �ֹι�ȣ, �μ� ��, ���� ��ȸ
SELECT EMP_NAME, EMP_ID, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
     JOIN JOB USING (JOB_CODE)
WHERE (SUBSTR(EMP_NO, 1, 2) BETWEEN '70' AND '79') 
    -- SUBSTR(EMP_NO, 1 , 2) >= 70 AND SUBSTR(EMP_NO, 1, 2) < 80
        AND SUBSTR(EMP_NO, 8, 1) = 2
        AND EMP_NAME LIKE '��%'; 
        
-- 2. ���� �� ���� ������ ��� �ڵ�, ��� ��, ����, �μ� ��, ���� �� ��ȸ ??
SELECT EMP_ID, EMP_NAME, 
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'))+1 ����, 
        DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
     JOIN JOB USING (JOB_CODE)
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'))+1
        = (SELECT MIN(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'))+1)
            FROM EMPLOYEE); 

-- 3. �̸��� '��'�� ���� ����� ��� �ڵ�, ��� ��, ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE EMP_NAME LIKE '%��%';

-- 4. �μ��ڵ尡 D5�̰ų� D6�� ����� ��� ��, ���� ��, �μ� �ڵ�, �μ� �� ��ȸ
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
     JOIN JOB USING (JOB_CODE)
WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D6';
    -- DEPT_CODE IN ('D5', 'D6');

-- 5. ���ʽ��� �޴� ����� ��� ��, �μ� ��, ���� �� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
     JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE BONUS IS NOT NULL;

-- 6. ��� ��, ���� ��, �μ� ��, ���� �� ��ȸ
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
     JOIN JOB USING (JOB_CODE)
     JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 7. �ѱ��̳� �Ϻ����� �ٹ� ���� ����� ��� ��, �μ� ��, ���� ��, ���� �� ��ȸ
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
     JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
     JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�' OR NATIONAL_NAME = '�Ϻ�';
    -- NATIONAL_NAME IN ('�ѱ�', '�Ϻ�');

-- 8. �� ����� ���� �μ����� ���ϴ� ����� �̸� ��ȸ (���� ����)
SELECT E.EMP_NAME, E.DEPT_CODE, D.EMP_NAME
FROM EMPLOYEE E
     JOIN EMPLOYEE D ON (E.DEPT_CODE = D.DEPT_CODE)
WHERE E.EMP_NAME != D.EMP_NAME
ORDER BY 1;

-- 9. ���ʽ��� ���� ���� �ڵ尡 J4�̰ų� J7�� ����� �̸�, ���� ��, �޿� ��ȸ(NVL �̿�)
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
     JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE NVL(BONUS, 0) = 0 AND J.JOB_CODE IN ('J4', 'J7');

-- 10. ���ʽ� ������ ������ ���� 5���� ���, �̸�, �μ� ��, ����, �Ի���, ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE, ����
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE,
      RANK() OVER(ORDER BY (SALARY + (SALARY * NVL(BONUS, 0))*12) DESC) ����
      FROM EMPLOYEE
           LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
           JOIN JOB USING (JOB_CODE))
WHERE ���� <= 5;

-- 11. �μ� �� �޿��� �հ谡 ��ü �޿� �� ���� 20%���� ���� �μ��� �μ� ��, �μ� �� �޿� �հ� ��ȸ
-- 11.1 JOIN�� HAVING ���
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY) * 0.2
                      FROM EMPLOYEE);
-- 11.2 �ζ��� �� ���
SELECT DEPT_TITLE, SS
FROM (SELECT DEPT_TITLE, SUM(SALARY) SS
      FROM EMPLOYEE
           LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
      GROUP BY DEPT_TITLE)
WHERE SS > (SELECT SUM(SALARY) * 0.2
            FROM EMPLOYEE);
-- ���� �ִ� SUM(SALARY)�� �����ͼ� ���ϴ� ���̱� ������ HAVING���� WHERE��

-- 11.3 WITH ���
WITH TOTAL AS (SELECT DEPT_TITLE, SUM(SALARY) SS
               FROM EMPLOYEE
                    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
               GROUP BY DEPT_TITLE)
SELECT DEPT_TITLE, SS
FROM TOTAL
WHERE SS > (SELECT SUM(SALARY) * 0.2
            FROM EMPLOYEE);

-- 12. �μ� ��� �μ� �� �޿� �հ� ��ȸ
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;

-- 13. WITH�� �̿��Ͽ� �޿� �հ� �޿� ��� ��ȸ
SELECT SUM(SALARY), AVG(SALARY)
FROM EMPLOYEE;

WITH SUM_SAL AS (SELECT SUM(SALARY) FROM EMPLOYEE),
     AVG_SAL AS (SELECT AVG(SALARY) FROM EMPLOYEE)
SELECT * FROM SUM_SAL
UNION 
SELECT * FROM AVG_SAL;

-- ���2
WITH SUM_SAL AS (SELECT SUM(SALARY) FROM EMPLOYEE),
     AVG_SAL AS (SELECT AVG(SALARY) FROM EMPLOYEE)
SELECT * FROM SUM_SAL, AVG_SAL;
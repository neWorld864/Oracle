-- SUBQUERY
-- 하나의 SQL문 안에 포함된 또 다른 SQL문
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY) 
                 FROM EMPLOYEE);


-- 부서코드가 노옹철사원과 같은 소속의 직원 명단 조회
-- 1) 사원 명이 노옹철인 사람의 부서 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

-- 2) 부서코드가 D9인 직원 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 3) 1+2
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '노옹철');
                   
-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여 조회
-- 1) 전 직원의 평균 급여 조회
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 2) 평균 급여보다 많은 급여를 받고 있는 직원
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3047662.60869565217391304347826086956522;

-- 3) 1+2
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEE);
                

-- 서브쿼리의 유형
-- 단일행 서브쿼리 : 서브쿼리의 조회 결과 값의 개수가 1개일 때
-- 다중행 서브쿼리 : 서브쿼리의 조회 결과 값의 행이 여러 개일 때
-- 다중열 서브쿼리 : 서브쿼리의 SELECT절에 나열된 항목 수가 여러 개일 때
-- 다중행 다중열 서브쿼리 : 조회 결과 행 수와 열 수가 여러 개일 때

-- 단일행 서브쿼리
-- 일반적으로 단일행 서브쿼리 앞에는 일반 연산자 사용
-- >, <, >=, <=, =, !=/<>/^=
-- 노옹철 사원의 급여보다 많이 받는 직원의 사번, 이름, 부서코드, 직급코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');
                
-- 가장 적은 급여를 받는 직원의 사번, 이름, 직급코드, 부서코드, 급여, 입사일 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > (SELECT MIN(SALARY)
                FROM EMPLOYEE);

-- 전 직원의 급여 평균보다 적은 급여를 받는 직원의 이름, 직급코드, 부서코드, 급여 조회 (직급 순으로 정렬)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE)
ORDER BY JOB_CODE;

-- 부서 별 급여의 합계 중 가장 큰 부서의 부서 명, 급여 합계 조회
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


-- 다중행 서브쿼리
-- 다중행 서브쿼리 앞에는 일반 비교 연산자 사용 못함
-- IN / NOT IN 
--              여러 개의 결과 값 중에서 한 개라도 일치하는 값이 있다면/없다면
-- > ANY, < ANY
--              여러 개의 결과 값 중에서 한 개라도 큰/작은 경우
--              가장 작은 값보다 크냐 / 가장 큰 값보다 작냐
-- > ALL, < ALL
--              모든 값보다 큰/작은 경우
--              가장 작은 값보다 작냐 / 가장 큰 값보다 크냐
-- EXISTS / NOT EXISTS
-- 값이 존재하는지/존재하지 않는지
-- IN vs EXISTS
--       IN : 값을 찾아서 반환
--       EXISTS : 있다/없다 = TRUE/FALSE

-- 부서 별 최고 급여를 받는 직원의 이름, 직급 코드, 부서 코드, 급여 조회
-- 1) 부서 별 최고 급여
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                 FROM EMPLOYEE
                 GROUP BY DEPT_CODE);

-- 관리자와 일반 직원에 해당하는 사원 정보 추출
-- 사번, 이름, 부서 명, 직급, 구분(관리자/직원)
-- 1) 관리자에 해당하는 사원 번호 조회
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

-- 2) 직원의 사번, 이름, 부서명, 직급 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE);

-- 3) 관리자에 해당하는 직원에 대한 정보 추출
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '관리자'구분
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL);

-- 4) 관리자에 해당하지 않는 직원에 대한 정보 추출
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME,  '직원'구분
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL);

-- 합치기               
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '관리자'구분
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME,  '직원'구분
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL);
                 
-- 방법 2
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, 
       CASE WHEN EMP_ID IN (SELECT DISTINCT(MANAGER_ID)
                            FROM EMPLOYEE
                            WHERE MANAGER_ID IS NOT NULL) THEN '관리자'
            ELSE '직원'
       END 구분
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE);
     
     
-- 대리 직급의 직원들 중에서 과장 직급의 최소 급여보다 많이 받는 직원의 사번, 이름, 직급, 급여 조회
-- 1) 대리 직급 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리';

-- 2) 과장 직급 직원의 급여
SELECT SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';

-- 3) 합치기
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
    AND SALARY > ANY(SELECT SALARY
                     FROM EMPLOYEE
                          JOIN JOB USING(JOB_CODE)
                     WHERE JOB_NAME = '과장');

-- 방법2         
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
    AND SALARY > (SELECT MIN(SALARY)
                  FROM EMPLOYEE
                       JOIN JOB USING(JOB_CODE)
                  WHERE JOB_NAME = '과장');
              

-- 차장 직급의 급여 중 가장 큰 값보다 많이 받는 과장 직급의 사번, 이름, 직급, 급여 조회
-- 1) 과장 직급 직원의 사번, 이름, 직급, 급여
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';

-- 2) 차장 직급의 급여
SELECT SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '차장';
                     
-- 3) 합치기
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
    AND SALARY > ALL(SELECT SALARY
                     FROM EMPLOYEE
                          JOIN JOB USING(JOB_CODE)
                     WHERE JOB_NAME = '차장');
                     
-- 방법2
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
    AND SALARY > (SELECT MAX(SALARY)
                     FROM EMPLOYEE
                          JOIN JOB USING(JOB_CODE)
                     WHERE JOB_NAME = '차장');
                     
-- 다중열 서브쿼리 : 주로 'IN"을 사용하지만 검색 결과가 분명이 한 개의 행이 보장된다면 '='도 사용한다.
-- 여러 개의 컬럼을 검색하는 서브 쿼리
-- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의 이름, 직급 코드, 부서 코드, 입사일 조회
-- 1) 퇴사한 여직원의 부서, 직급
SELECT JOB_CODE, DEPT_CODE
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2
      AND ENT_YN = 'Y';

-- 2) 퇴사한 여직원과 같은 부서, 같은 직급
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
      -- 같은 부서
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE SUBSTR(EMP_NO, 8, 1) = 2
                         AND ENT_YN = 'Y')
      -- 같은 직급
      AND JOB_CODE = (SELECT JOB_CODE
                      FROM EMPLOYEE
                      WHERE SUBSTR(EMP_NO, 8, 1) = 2
                            AND ENT_YN = 'Y')
      -- 중복 이름 제거
      AND EMP_NAME != (SELECT EMP_NAME
                       FROM EMPLOYEE
                       WHERE SUBSTR(EMP_NO, 8, 1) = 2
                             AND ENT_YN = 'Y');
                             



-- 3) 합치기
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
                             
-- 다중행 다중열 서브쿼리
-- 자기 직급의 평균 급여를 받고 있는 직원의 사번, 이름, 직급 코드, 급여 조회
-- 단, 급여와 급여 평균은 십만원 단위로 계산
-- 1) 직급 별 평균 급여
SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 2)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
                             FROM EMPLOYEE
                             GROUP BY JOB_CODE);
                             
-- 인라인 뷰(INLINE-VIEW)
SELECT EMP_NAME, ROWNUM FROM EMPLOYEE; -- 번호를 매겨줄 수 있는 컬럼

-- 전 직원 중 급여가 높은 상위 5명의 순위, 이름, 급여 조회
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC; -- 선동일, 송종기, 정중하, 대북혼, 노옹철
-- 오류 생김

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
-- 오류 생김, 먼저 FROM절부터 시작, FROM절에는 일반 EMPLOYEE고 여기서 5명을 데리고 온 상태에서 ORDER BY가 들어갔기 때문에

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
      FROM EMPLOYEE
      ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

-- 급여 평균 3위 안에 드는 부서의 부서 코드와 부서 명, 평균 급여 조회
SELECT DEPT_CODE, DEPT_TITLE, AVG(SALARY)
FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE ROWNUM <= 3
GROUP BY DEPT_CODE, DEPT_TITLE;

SELECT DEPT_CODE, DEPT_TITLE, 평균
FROM (SELECT DEPT_CODE, DEPT_TITLE, AVG(SALARY) 평균
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
SELECT 순위, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) 순위
      FROM EMPLOYEE);
-- 19	전형돈	2000000 / 19	윤은해	2000000 / 21	박나라	1800000

-- DENDE_RANK() OVER
SELECT 순위, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위
      FROM EMPLOYEE);
-- 19	전형돈	2000000 / 19	윤은해	2000000 / 20	박나라	1800000

-- WITH로
WITH DENSE AS (SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위
               FROM EMPLOYEE)
SELECT 순위, EMP_NAME, SALARY
FROM DENSE;


------- JOIN & SUBQUERY 실습 문제 -------
-- 1. 70년대 생(1970~1979) 중 여자이면서 전씨인 사원의 이름과 주민번호, 부서 명, 직급 조회
SELECT EMP_NAME, EMP_ID, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
     JOIN JOB USING (JOB_CODE)
WHERE (SUBSTR(EMP_NO, 1, 2) BETWEEN '70' AND '79') 
    -- SUBSTR(EMP_NO, 1 , 2) >= 70 AND SUBSTR(EMP_NO, 1, 2) < 80
        AND SUBSTR(EMP_NO, 8, 1) = 2
        AND EMP_NAME LIKE '전%'; 
        
-- 2. 나이 상 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회 ??
SELECT EMP_ID, EMP_NAME, 
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'))+1 나이, 
        DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
     JOIN JOB USING (JOB_CODE)
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'))+1
        = (SELECT MIN(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'))+1)
            FROM EMPLOYEE); 

-- 3. 이름에 '형'이 들어가는 사원의 사원 코드, 사원 명, 직급 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE EMP_NAME LIKE '%형%';

-- 4. 부서코드가 D5이거나 D6인 사원의 사원 명, 직급 명, 부서 코드, 부서 명 조회
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
     JOIN JOB USING (JOB_CODE)
WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D6';
    -- DEPT_CODE IN ('D5', 'D6');

-- 5. 보너스를 받는 사원의 사원 명, 부서 명, 지역 명 조회
SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
     JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE BONUS IS NOT NULL;

-- 6. 사원 명, 직급 명, 부서 명, 지역 명 조회
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
     JOIN JOB USING (JOB_CODE)
     JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 7. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
     JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
     JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국' OR NATIONAL_NAME = '일본';
    -- NATIONAL_NAME IN ('한국', '일본');

-- 8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회 (셀프 조인)
SELECT E.EMP_NAME, E.DEPT_CODE, D.EMP_NAME
FROM EMPLOYEE E
     JOIN EMPLOYEE D ON (E.DEPT_CODE = D.DEPT_CODE)
WHERE E.EMP_NAME != D.EMP_NAME
ORDER BY 1;

-- 9. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 이름, 직급 명, 급여 조회(NVL 이용)
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
     JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE NVL(BONUS, 0) = 0 AND J.JOB_CODE IN ('J4', 'J7');

-- 10. 보너스 포함한 연봉이 높은 5명의 사번, 이름, 부서 명, 직급, 입사일, 순위 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE, 순위
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE,
      RANK() OVER(ORDER BY (SALARY + (SALARY * NVL(BONUS, 0))*12) DESC) 순위
      FROM EMPLOYEE
           LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
           JOIN JOB USING (JOB_CODE))
WHERE 순위 <= 5;

-- 11. 부서 별 급여의 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회
-- 11.1 JOIN과 HAVING 사용
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY) * 0.2
                      FROM EMPLOYEE);
-- 11.2 인라인 뷰 사용
SELECT DEPT_TITLE, SS
FROM (SELECT DEPT_TITLE, SUM(SALARY) SS
      FROM EMPLOYEE
           LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
      GROUP BY DEPT_TITLE)
WHERE SS > (SELECT SUM(SALARY) * 0.2
            FROM EMPLOYEE);
-- 원래 있던 SUM(SALARY)를 가져와서 비교하는 것이기 때문에 HAVING말고 WHERE씀

-- 11.3 WITH 사용
WITH TOTAL AS (SELECT DEPT_TITLE, SUM(SALARY) SS
               FROM EMPLOYEE
                    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
               GROUP BY DEPT_TITLE)
SELECT DEPT_TITLE, SS
FROM TOTAL
WHERE SS > (SELECT SUM(SALARY) * 0.2
            FROM EMPLOYEE);

-- 12. 부서 명과 부서 별 급여 합계 조회
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;

-- 13. WITH를 이용하여 급여 합과 급여 평균 조회
SELECT SUM(SALARY), AVG(SALARY)
FROM EMPLOYEE;

WITH SUM_SAL AS (SELECT SUM(SALARY) FROM EMPLOYEE),
     AVG_SAL AS (SELECT AVG(SALARY) FROM EMPLOYEE)
SELECT * FROM SUM_SAL
UNION 
SELECT * FROM AVG_SAL;

-- 방법2
WITH SUM_SAL AS (SELECT SUM(SALARY) FROM EMPLOYEE),
     AVG_SAL AS (SELECT AVG(SALARY) FROM EMPLOYEE)
SELECT * FROM SUM_SAL, AVG_SAL;
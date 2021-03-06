/* 순서
    5 : SELECT      컬럼명 AS 별칭, 계산식, 함수식
    1 : FROM        참조할 테이블
    2 : WHERE       컬럼명 함수식 비교연산자 비교값
    3 : GROUP BY    그룹으로 묶을 컬럼명
    4 : HAVING      그룹함수식 비교연산자 비교값
    6 : ORDER BY    컬럼명 별칭 순번 정렬방식
*/

-- GROUP BY절 : 여러 개의 값을 묶어서 하나의 그룹으로 처리할 목적으로 사용
--SELECT DEPT_CODE, SUM(SALARY)
--FROM EMPLOYEE;
-- ORA-00937: not a single-group group function
-- 그룹함수는 단 한 개의 결과 값 산출, DEPT_CODE 여러 개 결과 값 산출

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;


-- EMPLOYEE테이블에서 부서 코드별 그룹을 지정하여 부서코드, 그룹별 급여의 합계,
-- 그룹 별 급여의 평균(정수처리), 인원수를 조회하고 부서 코드 순으로 정렬
SELECT DEPT_CODE 부서코드, SUM(SALARY) 합계, ROUND(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE테이블에서 부서코드와 보너스를 받는 사원 수를 조회하고 부서코드 순으로 정렬
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE 테이블에서 직급코드, 보너스를 받는 사원 수를 조회하여 직급코드 순으로 오름차순 정렬
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- EMPLOYEE테이블에서 성별과 성별 별 급여 평균(정수처리), 급여 합계, 인원 수 조회하고 인원수로 내림차순 정렬
SELECT DECODE(SUBSTR(EMP_NO,8, 1), 1, '남', '여') 성별, 
        ROUND(AVG(SALARY)) 급여평균, SUM(SALARY) 급여합계, COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8, 1), 1, '남', '여')
ORDER BY 인원수 DESC;

-- EMPLOYEE테이블에서 부서 코드 별로 같은 직급인 사원의 급여 합계 조회
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;

-- HAVING : 그룹함수로 구해올 그룹에 대해 조건을 설정할 때 사용
-- 부서코드와 급여 평균이 300만 이상인 그룹 조회
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

-- 부서 별 그룹의 급여 합계 중 9백만원을 초과하는 부서코드와 급여 합계 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000;

-- 집계함수
-- 그룹별 산출한 결과 값의 집계를 계산하는 함수
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

-- ROLLUP함수 : 그룹별로 중간 집계 처리를 하는 함수
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

-- CUBE
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

-- UNION == OR (합집합)
-- INTERSECT == AND (교집합)
-- UNION ALL == OR + AND (합집합 + 교집합) --> 중복된 부분이 두 번 포함
-- MINUS (차집합)

-- UNION : 여러 개의 쿼리 결과를 하나로 합치는 연산자
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 200
UNION
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 201;

-- UNION을 사용하여 DEPT_CODE가 D5이거나 급여가 300만을 초과하는 직원의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- 12개 행

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- 14개 행 : D5이면서 급여가 300만을 초과하는 사람들이 중복으로 나옴

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT -- 중복된 공통 부분을 추출하는 연산자
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
-- D5이면서 급여가 300만이 안 되는 사람들

-- 함수(FUNCTION) : 컬럼의 값을 읽어서 계산한 결과를 리턴
-- 단일행(SINGLE ROW)함수 : 컬럼에 기록된 n개의 값을 읽어서 n개의 결과를 리턴
-- 그룹(GROUP)함수 : 컬럼에 기록된 n개의 값을 읽어서 1개의 결과를 리턴

-- SELECT절에 단일행 함수와 그룹함수를 같이 사용 못 함 : 결과 행의 개수가 다르기 때문

-- 함수를 사용할 수 있는 위치 : SELECT절, WHERE절, GROUP BY절, HAVING절, ORDER BY절

-- 단일행 함수
-- 1. 문자 관련 함수
-- LENGTH / LENGTHB
-- LENGTHB : 글자의 바이트 사이즈 반환 : 한글은 한 글자 당 3바이트, 영어는 1바이트
SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL; -- DUAL : 가상 테이블
-- 3	9

SELECT LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;
-- 15	15 / 16	  16 / 14	14

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- INSTR : 해당 문자열의 위치 -- 제로 인덱스 아님! 그냥 1 2 3 4 순
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- 3
SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL; -- 0 : 없다는 의미의 0
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 3 : 앞에서부터 시작하는 곳
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- 10 : 뒤에서부터 시작하는 곳
SELECT INSTR('AABAACAABBAA', 'C', -1) FROM DUAL; -- 6
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 9 : 앞에서부터 두 번째 B
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL; -- 9

-- EMPLOYEE 테이블에서 이메일의 @위치 반환
SELECT INSTR(EMAIL, '@'), EMAIL
FROM EMPLOYEE;
-- 7	sun_di@kh.or.kr

-- LPAD / RPAD : 공백넣기
SELECT LPAD(EMAIL, 20), RPAD(EMAIL, 20) FROM EMPLOYEE;
--      sun_di@kh.or.kr
-- sun_di@kh.or.kr     

SELECT LPAD(EMAIL, 20, '#'), RPAD(EMAIL, 20, '#') FROM EMPLOYEE;
-- #####sun_di@kh.or.kr
-- sun_di@kh.or.kr#####

-- LTRIM / RTRIM : LTRIM은 맨 왼쪽에 있는 글자가 RTRIM이면 맨 오른쪽에 있는 글자가 ' ' 안에 포함된 글자면 자름 
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
SELECT TRIM('Z' FROM 'ZZZKHZZZZ') FROM DUAL; -- KH(공백) : 양쪽 끝부터 지워지기 시작
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZZ') FROM DUAL; -- KHZZZZ(공백) : 왼쪽 지워짐
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZZ') FROM DUAL; -- ZZZKH(공백) : 오른쪽 지워짐
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZZ') FROM DUAL; -- KH(공백) : 굳이 적고 싶으면 적기

-- SUBSTR
-- 컬럼이나 문자열에서 지정한 위치부터 지정한 개수의 문자열을 잘라내어 반환 = 자바에 String.subString()
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- THEMONEY
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL; -- ME
SELECT SUBSTR('SHOWMETHEMONEY', 5, 0) FROM DUAL; -- (NULL)
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL; -- SHOWME
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL; -- THE
SELECT SUBSTR('SHOWMETHEMONEY', -10, 2) FROM DUAL; -- ME
SELECT SUBSTR('쇼우 미 더 머니', 2, 5) FROM DUAL; -- 우 미 더

-- EMPLOYEE 테이블의 이름, 이메일, @이후를 제외한 아이디 조회
SELECT EMAIL FROM EMPLOYEE;
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1)
FROM EMPLOYEE;
-- 선동일 sun_di@kh.or.kr sun_di ...

-- 주민등록번호를 이용하여 남/녀 판단
-- EMPLOYEE테이블에서 이름과 주민번호에서 성별을 나타내는 부분 조회
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1)
FROM EMPLOYEE;
-- 선동일	 1
-- 송은희 2 ...

-- EMPLOYEE테이블에서 남자만 조회
SELECT EMP_NAME, '남' 성별
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;
-- 선동일	남 ...

-- EMPLOYEE테이블에서 여자만 조회
SELECT EMP_NAME, '여' 성별
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) =2;
-- 송은희	여 ...

-- EMPLOYEE테이블에서 직원들의 주민번호를 이용하여 사원 명, 생년, 생월, 생일 조회
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 2) 생년, SUBSTR(EMP_NO, 3, 2) 생월, SUBSTR(EMP_NO, 5, 2) 생일
FROM EMPLOYEE;
-- 선동일	 62	 12	 35 ...

-- LOWER / UPPER / INITCAP
SELECT LOWER('Welcome To My World') FROM DUAL; -- welcome to my world
SELECT UPPER('Welcome To My World') FROM DUAL; -- WELCOME TO MY WORLD
SELECT INITCAP('welcome to my world') FROM DUAL; -- Welcome To My World

-- CONCAT
SELECT CONCAT('가나다라', 'ABCD') FROM DUAL; -- 가나다라ABCD
SELECT '가나다라' || 'ABCD' FROM DUAL; -- 가나다라ABCD

-- REPLACE
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL; -- 서울시 강남구 삼성동

-- EMPLOYEE 테이블에서 이메일의 도메인을 gmail.com 변경하기
SELECT REPLACE(EMAIL, 'kh.or.kr', 'gmail.com') FROM EMPLOYEE;
-- sun_di@gmail.com ...

-- EMPLOYEE테이블에서 사원 명, 주민번호 조회
-- 단, 주민번호는 생년월일만 보이게하고 '-' 다음 값은 '*'로 바꾸기
SELECT EMP_NAME "사원 명", REPLACE(EMP_NO, SUBSTR(EMP_NO, 8, 7), '*******') 생년월일
FROM EMPLOYEE;

SELECT EMP_NAME "사원 명", SUBSTR(EMP_NO, 1, 7) || '*******' 생년월일
FROM EMPLOYEE;

SELECT EMP_NAME "사원 명", RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*') 생년월일
FROM EMPLOYEE;

SELECT EMP_NAME "사원 명", RPAD(SUBSTR(EMP_NO, 1, 7), LENGTH(EMP_NO), '*') 생년월일
FROM EMPLOYEE;
-- 선동일 621235-******* ...


-- 2. 숫자 관련 함수
-- ABS : 절대값 리턴
SELECT ABS(10.9) FROM DUAL; -- 10.9
SELECT ABS(-10.9) FROM DUAL; -- 10.9
SELECT ABS(10) FROM DUAL; -- 10
SELECT ABS(-10) FROM DUAL; -- 10

-- MOD : 나머지 리턴 -> 나뉘어지는 수의 부호를 따라감
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

-- FLOOR : 내림 -> 자릿수 지정 불가
SELECT FLOOR(123.456) FROM DUAL; -- 123
SELECT FLOOR(123.678) FROM DUAL; -- 123

-- TRUNC -> 자릿수 지정 가능
SELECT TRUNC(123.456) FROM DUAL; -- 123
SELECT TRUNC(123.678) FROM DUAL; -- 123
SELECT TRUNC(123.465, 1) FROM DUAL; -- 123.4
SELECT TRUNC(123.465, 2) FROM DUAL; -- 123.46
SELECT TRUNC(123.465, -1) FROM DUAL; -- 120

-- CEIL : 올림
SELECT CEIL(123.456) FROM DUAL; -- 124
SELECT CEIL(123.678) FROM DUAL; -- 124


-- 3. 날짜 관련 함수
-- SYSDATE : 오늘 날짜를 반환하는 함수
SELECT SYSDATE FROM DUAL; -- 21/02/08

-- MONTHS_BETWEEN : 개월 수의 차이를 숫자로 리턴하는 함수
-- EMPLOYEE테이블에서 사원의 이름, 입사일, 근무 개월수 조회
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEE;
-- 선동일 	90/02/06	372.419933542413381123058542413381123059 ...

SELECT EMP_NAME, HIRE_DATE, ABS(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
FROM EMPLOYEE;
-- 선동일	  90/02/06	372.419939142771804062126642771804062127 ...

SELECT EMP_NAME, HIRE_DATE, CEIL(ABS(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))) || '개월차' 개월차
FROM EMPLOYEE;
-- 선동일 	90/02/06	373개월차 ...

-- ADD_MONTHS : 날짜에 숫자만큼 개월수를 더한 날짜 리턴
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL; -- 21/07/08
SELECT ADD_MONTHS(SYSDATE, 12) FROM DUAL; -- 22/02/08

-- NEXT_DAY : 기준 날짜에서 구하려는 요일에 가장 가까운 날짜를 리턴하는 함수
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목요일') FROM DUAL; -- 21/02/08	21/02/11
SELECT SYSDATE, NEXT_DAY(SYSDATE, 5) FROM DUAL; -- 21/02/08	21/02/11 : 1=일, ... , 7=토
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목') FROM DUAL; -- 21/02/08	21/02/11
SELECT SYSDATE, NEXT_DAY(SYSDATE, '수박주스 맛있겠다') FROM DUAL; -- 21/02/08	21/02/10
SELECT SYSDATE, NEXT_DAY(SYSDATE, '지수와 상수는 이름에 수가 들어간다') FROM DUAL; -- 오류, 맨 앞 글자가 요일 글자여야 함

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL; -- 오류 ORA-01846: not a valid day of the week
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THU') FROM DUAL; -- 오류 ORA-01846: not a valid day of the week
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUROSEMARY') FROM DUAL; -- 오류 ORA-01846: not a valid day of the week
-- ㄴ ALTER SESSION SET NLS_LANGUAGE = AMERICAN; 을 해주면 잘 나옴

-- LAST_DAY : 해당 달에 마지막 날짜 리턴
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL; -- 21/02/08	21/02/28

------- 실습 문제 -------
-- 1. EMPLOYEE테이블에서 사원 명, 입사일-오늘, 오늘-입사일 조회
-- 단, 별칭은 근무일수1, 근무일수2로 하고 모두 정수처리(내림), 양수가 되도록 처리
SELECT EMP_NAME, FLOOR(ABS(HIRE_DATE - SYSDATE)) 근무일수1, FLOOR(ABS(SYSDATE - HIRE_DATE)) 근무일수2
FROM EMPLOYEE;
-- 선동일 	11336	11336 ...

-- 2. EMPLOYEE테이블에서 사번이 홀수인 직원들의 정보 모두 조회
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) <> 0;
-- 201	송종기	631156-1548654	song_jk@kh.or.kr	01045686656	D9	J2	S1	6000000		200	01/09/01		N
-- 203	송은희	631010-2653546	song_eh@kh.or.kr	01077607879	D6	J4	S5	2800000		204	96/05/03		N ...

-- 3. EMPLOYEE테이블에서 근무년수가 20년 이상인 직원 정보 조회
SELECT *
FROM EMPLOYEE
WHERE ABS(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) >= 240;

-- 방법 2
SELECT *
FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE; -- 인자로 전달받은 날짜에 인자로 받은 숫자만큼 개월 수를 더하여 특정 날짜 반환

-- 4. EMPLOYEE테이블에서 사원 명, 입사일, 입사한 월의 근무 일수 조회
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;
-- 선동일 	90/02/06	22

-- EXTRACT : 년, 월, 일 정보를 추출하여 리턴
-- EXTRACT(YEAR FROM 날짜)
-- EXTRACT(MONTH FROM 날짜)
-- EXTRACT(DAY FROM 날짜)
-- EMPLOYEE테이블에서 사원의 이름, 입사 연도, 입사 월, 입사 일 조회
SELECT EMP_NAME 사원명,
        EXTRACT(YEAR FROM HIRE_DATE) 입사년도,
        EXTRACT(MONTH FROM HIRE_DATE) 입사월,
        EXTRACT(DAY FROM HIRE_DATE) 입사일
FROM EMPLOYEE
--ORDER BY EMP_NAME;
--ORDER BY EMP_NAME ASC; -- 오름차순
--ORDER BY EMP_NAME DESC; -- 내림차순
--ORDER BY 사원명;
--ORDER BY "입사년도" DESC, 사원명; -- 입사년도 띄어쓰기 주의 
--ORDER BY "입사년도", 사원명 DESC;
ORDER BY 1; -- 테이블 1번을 기준으로 정렬하겠다
-- 김해술	 2004	4	30 ...

-- EMPLOYEE테이블에서 사원의 이름, 입사일, 근무년수 조회
-- 단 근무년수는 (현재 년도 - 입사년도)로 조회
SELECT EMP_NAME, HIRE_DATE, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수
FROM EMPLOYEE;
-- 선동일	 90/02/06	31 ...


-- 4. 형 변환 함수
-- TO_CHAR : 날짜형/숫자형 데이터를 문자형 데이터로 변경
SELECT TO_CHAR(1234) FROM DUAL; -- 1234
SELECT TO_CHAR(1234, '99999') FROM DUAL; --   1234 : 5칸 오른쪽 정렬, 빈칸 공백
SELECT TO_CHAR(1234, '00000') FROM DUAL; --  01234 : 5칸 오른쪽 정렬, 빈칸 0
SELECT TO_CHAR(1234, 'FML99999') FROM DUAL; -- ￦1234
-- FM: 공백제거 / L:그 나라 화폐단위
SELECT TO_CHAR(1234, '$99999') FROM DUAL; --   $1234
SELECT TO_CHAR(1234, 'FMS99999') FROM DUAL; -- +1234
SELECT TO_CHAR(1234, '99,999') FROM DUAL; --   1,234
SELECT TO_CHAR(1234, 'FM99,999') FROM DUAL; -- 1,234
SELECT TO_CHAR(1234, '00,000') FROM DUAL; --  01,234
SELECT TO_CHAR(1234, '999') FROM DUAL; -- ####

-- EMPLOYEE테이블에서 사원 명, 급여 표시
-- 급여는 '\9,000,000'형식으로 표시
SELECT EMP_NAME, TO_CHAR(SALARY, 'FML9,999,999')
FROM EMPLOYEE;
-- 선동일	 ￦8,000,000 ...

SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL; -- 오후 13:39:12
SELECT TO_CHAR(SYSDATE, 'AM HH24:MI:SS') FROM DUAL; -- 오후 13:39:17
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- 오후 01:39:23
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL; -- 2월  월, 2021 / 2월  금, 2021
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL; -- 2021-02-08 월요일
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY') FROM DUAL; -- 2021-2-8 월요일
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') FROM DUAL; -- TWENTY TWENTY-ONE, 1

SELECT TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'YEAR')  
FROM DUAL;
-- 2021	21	TWENTY TWENTY-ONE

SELECT TO_CHAR(SYSDATE, 'MM'), 
        TO_CHAR(SYSDATE, 'MONTH'), 
        TO_CHAR(SYSDATE, 'MON'), 
        TO_CHAR(SYSDATE, 'RM')
FROM DUAL;
-- 02	2월 	2월 	II  

SELECT TO_CHAR(SYSDATE, 'DDD'),
        TO_CHAR(SYSDATE, 'DD'),
        TO_CHAR(SYSDATE, 'D')
FROM DUAL;
-- 050	19	6

-- EMPLOYEE테이블에서 이름, 입사일 조회
-- 입사일은 '2021년 02월 08일 (월)' 형식으로 출력
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일" "("DY")"')
FROM EMPLOYEE;
-- 선동일	1990년 02월 06일 (화)

-- TO_NUMBER : 문자형 데이터를 숫자형 데이터
SELECT TO_NUMBER('123456') FROM DUAL;
-- 123456

SELECT '123' + '456' FROM DUAL; -- 579
SELECT '1,000,000' + '550,000' FROM DUAL;
SELECT TO_NUMBER('1,000,000', '9,999,999') + TO_NUMBER('550,000', '999,999') FROM DUAL; -- 1550000
--             변환하려는 데이터   출력 형식

-- TO_DATE
SELECT TO_DATE('20210101', 'YYYYMMDD') FROM DUAL; -- 21/01/01
SELECT TO_DATE(20210101, 'YYYYMMDD') FROM DUAL; -- 21/01/01
SELECT TO_CHAR(TO_DATE('20210208', 'YYYYMMDD'), 'YYYY, MON') FROM DUAL; -- 2021, 2월 

-- RR과 YY의 차이
SELECT TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYYYMMDD') FROM DUAL; -- 20980630
SELECT TO_CHAR(TO_DATE('210630', 'YYMMDD'), 'YYYYMMDD') FROM DUAL; -- 20210630
SELECT TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYYMMDD') FROM DUAL; -- 19980630
SELECT TO_CHAR(TO_DATE('210630', 'RRMMDD'), 'YYYYMMDD') FROM DUAL; -- 20210630
-- YY : 20 / RR : 어쩔 땐 19 어쩔 땐 20

-- 5. NULL 처리 함수
-- NVL : 컬럼 값이 NULL일 때 바꿀 값으로 대체
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;
-- 송종기	 (null)	  0 ...

SELECT EMP_NAME, NVL(DEPT_CODE, '없습니다')
FROM EMPLOYEE;
-- 하동운	 없습니다

-- NVL2 : 해당 컬럼의 값이 있으면 바꿀 값1로 변경, 해당 컬럼의 값이 없으면 바꿀 값2로 변경
-- EMPLOYEE테이블에서 보너스가 NULL인 직원은 0.5로, NULL이 아닌 경우 0.7 변경
SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.5)
FROM EMPLOYEE;
-- 선동일	  0.3	0.7
-- 송종기	 	    0.5

-- NULLIF : 두 개의 값이 동일하면 NULL, 그렇지 않으면 비교대상1 리턴
SELECT NULLIF(123, 123) FROM DUAL; -- (NULL)
SELECT NULLIF(123, 124) FROM DUAL; -- 123


-- 6. 선택 함수
-- DECODE : 비교하고자하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환(SWITCH)
SELECT EMP_ID, EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여')
FROM EMPLOYEE;
-- 200	선동일	621235-1985634	남

SELECT EMP_ID, EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', '여')
FROM EMPLOYEE;
-- 200	선동일	621235-1985634	남

-- 직원의 급여를 인상하고자 한다
-- 직급코드가 J7인 직원은 급여의 10%를 인상하고
-- 직급코드가 J6인 직원은 급여의 15%를 인상하고
-- 직급코드가 J5인 직원은 급여의 20%를 인상하며
-- 그 외 직급의 직원은 급여의 5%만 인상한다.
-- 직원 테이블에서 직원명, 직급코드, 급여, 인상급여(위 조건)을 조회하세요
SELECT EMP_NAME, JOB_CODE, SALARY,
        DECODE(JOB_CODE, 'J7', SALARY*1.1, 
                         'J6', SALARY*1.15, 
                         'J5', SALARY*1.2, 
                         SALARY*1.05) 인상급여
FROM EMPLOYEE;
-- 선동일	    J1	8000000	8400000
-- 송종기 	J2	6000000	6300000


-- CASE WHEN 조건식 THEN 결과값
--      WHEN 조건식 THEN 결과값
--      ELSE 결과값
-- END
-- 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환, 조건은 범위 값 가능

SELECT EMP_ID, EMP_NAME, EMP_NO, 
        CASE WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '남자'
             WHEN SUBSTR(EMP_NO, 8, 1) = 2 THEN '여자'
        END 성별
FROM EMPLOYEE;
-- 200	선동일	621235-1985634	남자

SELECT EMP_ID, EMP_NAME, EMP_NO, 
        CASE WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '남자'
             ELSE '여자'
        END 성별
FROM EMPLOYEE;
-- 200	선동일	621235-1985634	남자

SELECT EMP_NAME, JOB_CODE, SALARY,
        CASE WHEN JOB_CODE = 'J7' THEN SALARY*1.1
             WHEN JOB_CODE = 'J6' THEN SALARY*1.15
             WHEN JOB_CODE = 'J5' THEN SALARY*1.2
             ELSE SALARY*1.05
             END 인상급여
FROM EMPLOYEE;
-- 선동일  J1  8000000	8400000

SELECT EMP_NAME, JOB_CODE, SALARY,
        CASE JOB_CODE WHEN 'J7' THEN SALARY*1.1
                      WHEN 'J6' THEN SALARY*1.15
                      WHEN 'J5' THEN SALARY*1.2
                      ELSE SALARY*1.05
             END 인상급여
FROM EMPLOYEE;
-- 선동일	 J1	8000000	8400000

SELECT EMP_ID, EMP_NAME, SALARY,
         CASE WHEN SALARY > 5000000 THEN '1등급'
              WHEN SALARY > 5000000 THEN '1등급'
              WHEN SALARY > 5000000 THEN '1등급'
              ELSE '4등급'
         END 등급
FROM EMPLOYEE;       
-- 200	선동일	8000000	1등급
    
    
-- 그룹 함수
-- 여러 개의 행을 넣으면 한 개의 결과를 리턴하는 함수
-- SUM
-- EMPLOYEE테이블에서 전 사원의 급여 총합
SELECT SUM(SALARY)
FROM EMPLOYEE; -- 74396240

-- EMPLOYEE테이블에서 남자 사원의 급여 총합 조회
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1; -- 54060000

-- EMPLOYEE테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉 합계 조회
SELECT SUM((SALARY + (SALARY*BONUS))*12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'; -- 77340000


-- AVG
-- EMPLOYEE테이블에서 전 사원의 급여 평균
SELECT AVG(SALARY)
FROM EMPLOYEE; -- 3099843.33333333333333333333333333333333

-- EMPLOYEE테이블에서 전 사원의 보너스 평균을 소수 셋째자리에서 반올림한 것 조회
-- BONUS가 NULL인 사원은 0으로 처리
SELECT ROUND(AVG(NVL(BONUS, 0)), 2)
FROM EMPLOYEE; -- 0.09

-- MIN
-- EMPLOYEE 테이블에서 가장 적은 급여 조회
SELECT MIN(SALARY)
FROM EMPLOYEE; -- 1380000

-- EMPLOYEE테이블에서 알파벳 순서가 가장 빠른 이메일, 가장 빠른 입사일 조회
SELECT MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;
-- bang_ms@kh.or.kr  90/02/06

-- MAX
-- EMPLOYEE테이블에서 가장 많은 급여 조회
SELECT MAX(SALARY)
FROM EMPLOYEE; -- 8000000

-- EMPLOYEE테이블에서 알파벳 순서가 가장 늦은 이메일, 가장 최근 입사일 조회
SELECT MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;
-- youn_eh@kh.or.kr	 21/02/17

-- COUNT : NULL 미포함
SELECT COUNT(*) /*행 개수*/, COUNT(DEPT_CODE)/*널이 아닌값 개수*/, COUNT(DISTINCT DEPT_CODE) /*-- 중복값 제거후 개수*/  -- 23	21	6
FROM EMPLOYEE;
-- 24	22	6


---------- 함수 연습문제 ----------
--1. 직원명과 주민번호를 조회함
--  단, 주민번호 9번째 자리부터 끝까지는 '*'문자로 채움
--  예 : 홍길동 771120-1******
SELECT EMP_NAME "직원 명", SUBSTR(EMP_NO, 1, 8) || '******' 생년월일
FROM EMPLOYEE;
-- 선동일	621235-1******

--2. 직원명, 직급코드, 보너스가 포함된 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
SELECT EMP_NAME, JOB_CODE, TO_CHAR((SALARY*(1+NVL(BONUS, 0)))*12, 'FML999,999,999') "보너스 포함 연봉"
FROM EMPLOYEE;
-- 선동일	J1	￦124,800,000

--3. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원의 사번, 사원명, 부서코드, 입사일
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D5' OR DEPT_CODE = 'D9') AND  EXTRACT(YEAR FROM HIRE_DATE) = 2004;
-- 208	김해술	D5	04/04/30

--4. 직원명, 입사일, 입사한 달의 근무일수 조회(단, 주말과 입사한 날도 근무일수에 포함함)
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE) - HIRE_DATE + 1
FROM EMPLOYEE;
-- 선동일  90/02/06	23

--5. 부서코드가 D5와 D6이 아닌 사원들의 직원명, 부서코드, 생년월일, 나이(만) 조회
--  단, 생년월일은 주민번호에서 추출해서 ㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 하고
--  나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음 계산
SELECT EMP_NAME, DEPT_CODE, 
        SUBSTR(EMP_NO, 1, 2) || '년 ' || SUBSTR(EMP_NO, 3, 2) || '월 ' || SUBSTR(EMP_NO, 5, 2) || '일' 생일,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RRRR')) 나이
FROM EMPLOYEE;
-- 선동일	 D9	 62년 12월 35일	59

--6. 직원들의 입사일로 부터 년도만 가지고, 각 년도별 입사인원수를 구하시오.
--  아래의 년도에 입사한 인원수를 조회하시오.
--  => to_char, decode, count 사용
--   -------------------------------------------------------------
--   전체직원수   2001년   2002년   2003년   2004년
--   -------------------------------------------------------------
SELECT COUNT(*) 전체직원수, 
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2001', 1)) "2001년",
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2002', 1)) "2002년",
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2003', 1)) "2003년",
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2004', 1)) "2004년"
FROM EMPLOYEE;
-- 24	3	0	0	1

--7.  부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회함
--  => case 사용
SELECT EMP_NAME, DEPT_CODE,
        CASE WHEN DEPT_CODE = 'D5' THEN '총무부'
             WHEN DEPT_CODE = 'D6' THEN '기획부'
             WHEN DEPT_CODE = 'D9' THEN '영업부'
             END 부서
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D6' OR DEPT_CODE = 'D9'
ORDER BY 3;
-- 정중하	 D6	 기획부
-- 유재식	 D6	 기획부
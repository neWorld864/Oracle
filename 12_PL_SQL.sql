-- PL/SQL : 오라클 자체에 내장되어 있는 절차적 언어
-- 선언부 : DECLARE로 시작, 변수, 상수를 선언하는 부분
-- 실행부 : BEGIN으로 시작, 조건문, 반복문, 함수 정의 등 로직 기술
-- 예외처리부 : EXCEPTION으로 시작, 예외 발생 시 해결하기 위한 문장 기술

/*
    System.out.println("Hello World");
*/
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;
/ 
/*이 슬래시를 보고 PL/SQL이 끝났구나를 인지*/

SET SERVEROUTPUT ON;
-- 프로시저를 사용하여 출력하는 내용을 화면에 보여주도록 설정하는 환경변수로 
-- 기본 값은 OFF여서 ON으로 변경

/*  자바
    int empId
    String empName;
    final int PI = 3.14;
    
    empId = 888;
    empName = '배정남';
    
    System.out.println("empId : " + empId);
    System.out.println("empName : " + empName);
    System.out.println("PI : " + PI);
*/
DECLARE
    EMP_ID NUMBER;         -- NUMBER타입 변수 EMP_ID 선언
    EMP_NAME VARCHAR2(30); -- VARCHAR2타입 변수 EMP_NAME 선언
    PI CONSTANT NUMBER := 3.14; -- NUMBER타입 상수 PI 선언 및 초기화 : := 대입 연산자
BEGIN
    EMP_ID := 888;
    EMP_NAME := '배정남';
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME -- 컬럼(EMPLOYEE 테이블 안에 있는 컬럼)
    INTO EMP_ID, EMP_NAME -- 위에서 선언한 필드
    FROM EMPLOYEE 
    WHERE EMP_ID = 200; -- 컬럼에 있는 EMP_ID
    
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
    WHERE EMP_ID = '&사번'; -- 사번이라고 해도 같은 값이 나온다, 사번은 안내문구를 대신 적은 것일 뿐
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
END;
/

-- 레퍼런스 변수로 EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY를 선언하고
-- EMPLOYEE테이블에서 사번, 이름, 직급코드, 부서코드, 급여 조회 후 선언한 레퍼런스 변수에 담아 출력
-- 단, 입력 받은 이름과 일치하는 조건의 사원 조회
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE; -- 거기있는 애를 참조해오겠다
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    INTO EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    FROM EMPLOYEE 
    WHERE EMP_NAME = '&이름'; 
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('DEPT_CODE : ' || DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('JOB_CODE : ' || JOB_CODE);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
END;
/

DECLARE
--      EMP_NAME EMPLOYEE.EMP_NAME%TYPE
    E EMPLOYEE%ROWTYPE; -- 행 전체를 가져옴
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('EMP_NO : ' || E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || E.SALARY);
END;
/

-- 조건문
-- IF ~ THEN ~ END IF (단일 IF문)
-- EMP_ID를 입력 받아 해당 사원의 사번, 이름, 급여, 보너스율 출력
-- 단, 보너스를 받지 않는 사원은 보너스율 출력 전 '보너스를 지급받지 않는 사원입니다.' 출력
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    INTO EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
    -- IF(BONUS IS NULL)
    IF(BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;
    
    
    DBMS_OUTPUT.PUT_LINE('보너스율 : ' || BONUS * 100 || '%');
END;
/
--210223
-- IF ~ THEN ~ ELSE ~ END IF (IF ~ ELSE문)
-- EMP_ID를 입력받아 해당 사원의 사번, 이름, 부서명, 소속 출력
-- TEAM변수를 만들어 소속이 'KO'인 사원은 '국내팀', 아닌 사원은 '해외팀'으로 저장
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
    WHERE EMP_ID = '&사번'; 
    
    IF(NATIONAL_CODE = 'KO') THEN TEAM := '국내팀';
    ELSE TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('소속 : ' || TEAM);

END;
/
-- 항상 SET SERVEROUTPUT ON;을 하고 수행해야 한다!!! 짱 중요


-- 사원의 연봉을 구하는 PL/SQL 블럭 작성
-- 보너스가 있는 사원은 보너스도 포함하여 계산
-- 사용자에게 사번을 받아와 그 사원의 전체 정보를 VEMP에 저장 후
-- VEMP를 이용하여 연봉 계산
-- 연봉을 계산한 결과 값은 YSALARY에 저장
-- '급여 이름 연봉(\1,000,000 형식)'로 출력
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

-- IF ~ THEN ~ ELSIF ~ THEN ~ ELSE ~ END IF (IF ~ ELSE IF ~ ELSE문)
-- 점수를 입력 받아 SCORE변수에 저장하고
-- 90점 이상은 'A', 80점 이상은 'B', 70점 이상은 'C'
-- 60점 이상은 'D', 60점 미만은 'F'로 처리하여 GRADE변수에 저장
-- 당신의 점수는 90점이고, 학점은 A학점입니다. 형태로 출력

DECLARE
    SCORE NUMBER; -- 숫자 형태로 저장되는 변수
    GRADE VARCHAR2(2); -- 문자 형태로 저장되는 변수
BEGIN
    SCORE := '&점수';
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;

    DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || SCORE || '점이고, 학점은 ' || GRADE || '학점입니다.');
    
END;
/

-- CASE ~ WHEN ~ THEN ~ END(SWITCH ~ CASE문)
-- 사원 번호를 입력하여 해당 사원의 사번, 이름, 부서명 출력
-- IF 사용 시
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&ID';

    IF EMP.DEPT_CODE = 'D1' THEN DNAME := '인사관리부';
    ELSIF EMP.DEPT_CODE = 'D2' THEN DNAME := '회계관리부';
    ELSIF EMP.DEPT_CODE = 'D3' THEN DNAME := '마케팅부';
    ELSIF EMP.DEPT_CODE = 'D4' THEN DNAME := '국내영업부';
    ELSIF EMP.DEPT_CODE = 'D5' THEN DNAME := '해외영업1부';
    ELSIF EMP.DEPT_CODE = 'D6' THEN DNAME := '해외영업2부';
    ELSIF EMP.DEPT_CODE = 'D7' THEN DNAME := '해외영업3부';
    ELSIF EMP.DEPT_CODE = 'D8' THEN DNAME := '기술지원부';
    ELSIF EMP.DEPT_CODE = 'D9' THEN DNAME := '총무부';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번  이름  부서명');
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
                WHEN 'D1' THEN '인사관리부'
                WHEN 'D2' THEN '회계관리부'
                WHEN 'D3' THEN '마케팅부'
                WHEN 'D4' THEN '국내영업부'
                WHEN 'D5' THEN '해외영업1부'
                WHEN 'D6' THEN '해외영업2부'
                WHEN 'D7' THEN '해외영업3부'
                WHEN 'D8' THEN '기술지원부'
                WHEN 'D9' THEN '총무부'
            END;
            
    DBMS_OUTPUT.PUT_LINE('사번  이름  부서명');
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID || ' ' || EMP.EMP_NAME || ' ' || DNAME);
END;
/

-- 반복문
-- BASIC LOOP : 내부에 처리문을 작성하고 마지막에 LOOP문을 벗어날 조건 명시
/*
    LOOP
        처리문
        조건문
    END LOOP;
    
    조건문 : IF 조건식 THEN EXIT; END IF;
            EXIT WHEN 조건식;
*/

-- 1 ~ 5까지 순차적 출력
DECLARE
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N + 1;
    -- 방법1
--      IF(N > 5) THEN EXIT;
--      END IF;
    -- 방법2 
        EXIT WHEN N > 5;
    END LOOP;
END;
/


-- FOR LOOP

/*
    FOR 인덱스 IN [REVERSE] 초기값..최종값
    LOOP
        처리문
    END LOOP;
*/
-- 1 ~ 5까지 순서대로 출력
BEGIN
    FOR N IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- 1 ~ 5까지 거꾸로 출력
BEGIN
--    FOR N IN 5..1
    FOR N IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- 이거 뭔지 다시 보기 0223 4교시
--BEGIN
--    FOR N IN 1..10
--    LOOP
--        INSERT INTO TEST1 VALUES(I, SYSDATE);
--    END LOOP;
--END;
--/
--
--SELECT * FROM TEST1;

-- 중첩 반복문
-- 구구단 짝수단 출력하기

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
    WHILE 조건
    LOOP
        처리문
    END LOOP;
*/
-- 1 ~5 순서대로 출력
DECLARE
    N NUMBER := 1;
BEGIN
    WHILE N <= 5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- WHILE문으로 구구단 짝수단 출력
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
-- 미리 정의된 예외 종류
-- NO_DATA_FOUND : SELECT문이 아무런 데이터 행을 반환하지 못 할 때
-- DUP_VAL_ON_INDEX : UNIQUE제약을 갖는 컬럼에 중복되는 데이터가 들어갈 때
-- ZERO_DIVIDE : 0으로 나눌 때
-- INVALID_CURSOR : 잘못된 커서 연산
-- 등...

BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&사번'
    WHERE EMP_ID = 200;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX
    THEN DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다');
END;
/

DECLARE
    NAME VARCHAR2(30);
BEGIN
    SELECT EMP_NAME
    INTO NAME
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('조회 결과가 없습니다.');
END;
/
